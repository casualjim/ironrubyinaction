$LOAD_PATH << File.dirname(__FILE__) + '/dependencies'
require 'acmgd.dll'
require 'acdbmgd.dll'
 
Ai =  Autodesk::AutoCAD::Internal
Aiu = Autodesk::AutoCAD::Internal::Utils
Aas = Autodesk::AutoCAD::ApplicationServices
Ads = Autodesk::AutoCAD::DatabaseServices
Aei = Autodesk::AutoCAD::EditorInput
Agi = Autodesk::AutoCAD::GraphicsInterface
Ag =  Autodesk::AutoCAD::Geometry
Ac =  Autodesk::AutoCAD::Colors
Ar =  Autodesk::AutoCAD::Runtime

def print_message(msg)
  app = Aas::Application
  doc = app.document_manager.mdi_active_document
  ed = doc.editor
  ed.write_message(msg)
end

def autocad_command(cmd)
  cc = Ai::CommandCallback.new method(cmd)
  Aiu.add_command('rbcmds', cmd, cmd, Ar::CommandFlags.Modal, cc)
 
  print_message("\nRegistered Ruby command: " + cmd)
end
 
def add_commands(names)
  names.each { |n| autocad_command n }
end

APP_NAME = "TTIF_PIPE"
APP_CODE = 1001
RAD_CODE = 1040
 
def pipe_radius_for_object(obj)
 
  res = 0.0
 
  begin 
    rb = obj.x_data
    return res if rb.nil?
 
    rb.each do |tv|
      foundStart = tv.type_code == APP_CODE and tv.value == APP_NAME
      
      if foundStart and tv.type_code == RAD_CODE
        res = tv.value
        break
      end
    end
  rescue
    return 0.0
  end
  return res
end
 
def set_pipe_radius_for_object(tr, obj, radius)
 
  db = obj.database
 
  rat = tr.get_object(db.reg_app_table_id, Ads::OpenMode.for_read)
 
  unless rat.has(APP_NAME)
    rat.upgrade_open()
    ratr = Ads::RegAppTableRecord.new
    ratr.name = APP_NAME
    rat.add(ratr)
    tr.add_newly_created_d_b_object(ratr, true)
  end
 
  rb = Ads::ResultBuffer.new(
      Ads::TypedValue.new(APP_CODE, APP_NAME),
      Ads::TypedValue.new(RAD_CODE, radius))
  obj.x_data = rb
  rb.dispose
 
end

class PipeDrawOverrule < Agi::DrawableOverrule

  def initialize
   set_x_data_filter($appName)
  end

end

class LinePipeDrawOverrule < PipeDrawOverrule

  def initialize
    @sweepOpts = Ads::SweepOptions.new
    super
  end

  def world_draw(d, wd)

    radius = pipeRadiusForObject(d)

    if radius > 0.0 

      parent_world_draw(d, wd)

      unless d.id.is_null and d.length > 0.0
        c = wd.sub_entity_traits.true_color
        wd.sub_entity_traits.true_color =
          Ac::EntityColor.new 0x00AFAFFF
        wd.sub_entity_traits.line_weight =
          Ads::LineWeight.line_weight_000
        start = d.start_point
        endpt = d.end_point
        norm = Ag::Vector3d.new(
          endpt.X - start.X,
          endpt.Y - start.Y,
          endpt.Z - start.Z)
        clr = Ads::Circle.new start, norm, radius
        pipe = Ads::ExtrudedSurface.new
        begin
          pipe.create_extruded_surface(clr, norm, @sweep_opts)
        rescue
          print_message "\nFailed with CreateExtrudedSurface."
        end
        clr.dispose()
        pipe.world_draw(wd)
        pipe.dispose()
        wd.sub_entity_traits.true_color = c
      end
      return true
    end
    return super
  end
 
  def set_attributes(d, t)
 
    i = parent_set_attributes(d, t)
 
    radius = pipe_radius_for_object(d)
 
    if radius > 0.0
      t.color = 6
      t.line_weight = Ads::LineWeight.line_weight_040
    end
    return i
  end
end

class CirclePipeDrawOverrule < PipeDrawOverrule

  def initialize
    @sweep_opts = Ads::SweepOptions.new
    super
  end

  def world_draw(d, wd)

    radius = pipe_radius_for_object(d)

    if radius > 0.0

      parent_world_draw(d, wd)

      if d.radius > radius
        
        c = wd.sub_entity_traits.true_color
        wd.sub_entity_traits.true_color =
          Ac::EntityColor.new 0x3FFFE0E0
        wd.sub_entity_traits.line_weight =
          Ads::LineWeight.LineWeight000
        start = d.StartPoint
        cen = d.Center
        norm = Ag::Vector3d.new(
          cen.X - start.X,
          cen.Y - start.Y,
          cen.Z - start.Z)
        clr =
          Ads::Circle.new start, norm.cross_product(d.normal), radius
        pipe = Ads::SweptSurface.new
        pipe.create_swept_surface(clr, d, @sweep_opts)
        clr.dispose()
        pipe.world_draw(wd)
        pipe.dispose()
        wd.sub_entity_traits.true_color = c
      end
      return true
    end
    return parent_world_draw(d, wd)
  end

  def set_attributes(d, t)

    i = parent_set_attributes(d, t)

    radius = pipe_radius_for_object(d)

    if radius > 0.0
      t.color = 2
      t.line_weight = Ads::LineWeight.line_weight_060
    end
    return i
  end
end

class LinePipeTransformOverrule < Ads::TransformOverrule

  def initialize
    @sweep_opts = Ads::SweepOptions.new
  end

  def explode(e, objs)
    radius = pipe_radius_for_object(e)

    return nil if radius > 0.0

    if not e.id.is_null and e.length > 0.0

      # Draw a pipe around the line 
      start = e.start_point
      endpt = e.end_point
      norm = Ag::Vector3d.new(
        endpt.x - start.x,
        endpt.y - start.y,
        endpt.z - start.z
      )
      clr = Ads::Circle.new start, norm, radius
      pipe = Ads::ExtrudedSurface.new
      begin
        pipe.create_extruded_surface clr, norm, @sweep_opts
      rescue
        print_message "\nFailed with CreateExtrudedSurface."
      end
      clr.dispose()
      objs.add(pipe)
    end

    super
  end
end

class CirclePipeTransformOverrule < Ads::TransformOverrule

  # An overrule to explode a circular pipe into Solid3d objects 
  def initialize
    @sweep_opts = Ads::SweepOptions.new
  end

  def explode(e, objs)
    radius = pipe_radius_for_object(e)

    return nil if radius > 0.0

    if e.radius > radius

      start = e.start_point
      cen = e.center
      norm = Ag::Vector3d.new(
        cen.x - start.x,
        cen.y - start.y,
        cen.z - start.z
      )
      clr = Ads::Circle.new start, norm.cross_product(e.normal), radius
      pipe = Ads::SweptSurface.new
      pipe.create_swept_surface(clr, e, @sweep_opts)
      clr.dispose()
      objs.add(pipe)
    end
    
    super
  end
end

def overrule(enable)
 
  Ar::Overrule.Overruling = enable
  if enable
    Aas::Application.set_system_variable("LWDISPLAY", 1)
  else
    Aas::Application.set_system_variable("LWDISPLAY", 0)
  end
 
  doc = Aas::Application.document_manager.mdi_active_document
  doc.send_string_to_execute("REGEN3\n", true, false, false)
  doc.editor.regen()
 
end
 
$overruling = false
$radius = 0.0
 
def overrule1
 
  begin
    unless $overruling
      $lpdo = LinePipeDrawOverrule.new      
      $cpdo = CirclePipeDrawOverrule.new      
      $lpto = LinePipeTransformOverrule.new
      $cpto = CirclePipeTransformOverrule.new
 
      Ads::ObjectOverrule.add_overrule(
        Ar::RXClass::get_class(Ads::Line.to_clr_type),
        $lpdo,
        true)
      Ads::ObjectOverrule.add_overrule(
        Ar::RXClass::get_class(Ads::Line.to_clr_type),
        $lpto,
        true)
      Ads::ObjectOverrule.add_overrule(
        Ar::RXClass::get_class(Ads::Circle.to_clr_type),
        $cpdo,
        true)
      Ads::ObjectOverrule.add_overrule(
        Ar::RXClass::get_class(Ads::Circle.to_clr_type),
        $cpto,
        true)
 
      $overruling = true
      overrule(true)
    end
  rescue
    print_message("\nProblem found: " + $! + "\n")
  end
end
 
def overrule0
 
  begin
    if $overruling
 
      Ads::ObjectOverrule.remove_overrule(
        Ar::RXClass::get_class(Ads::Line.to_clr_type),
        $lpdo)
      Ads::ObjectOverrule.remove_overrule(
        Ar::RXClass::get_class(Ads::Line.to_clr_type),
        $lpto)
      Ads::ObjectOverrule.remove_overrule(
        Ar::RXClass::get_class(Ads::Circle.to_clr_type),
        $cpdo)
      Ads::ObjectOverrule.remove_overrule(
        Ar::RXClass::get_class(Ads::Circle.to_clr_type),
        $cpto)
 
      $overruling = false
      overrule(false)
    end
  rescue
    print_message("\nProblem found: " + $! + "\n")
  end
end

def makePipe()
 
  begin
    doc = Aas::Application.document_manager.mdi_active_document
    db = doc.database
    ed = doc.editor
 
    pso = Aei::PromptSelectionOptions.new
    pso.allow_duplicates = false
    pso.message_for_adding =
      "\nSelect objects to turn into pipes: "
 
    sel_res = ed.get_selection(pso)
 
    if sel_res.status != Aei::PromptStatus.OK
      return
    end
 
    ss = sel_res.value
 
    pdo = Aei::PromptDoubleOptions.new "\nSpecify pipe radius:"
 
    if $radius > 0.0
      pdo.default_value = $radius
      pdo.use_default_value = true
    end
 
    pdo.allow_negative = false
    pdo.allow_zero = false
 
    pdr = ed.get_double(pdo)
    if pdr.status != Aei::PromptStatus.OK
      return
    end
 
    $radius = pdr.value
 
    tr = db.transaction_manager.start_transaction()
 
    for o in ss do
      obj = tr.get_object(o.object_id, Ads::OpenMode.for_write)
      set_pipe_radius_for_object(tr, obj, $radius)
    end
 
    tr.commit()
    tr.dispose()
  rescue
    print_message("\nProblem found: " + $! + "\n")
  end
end

add_commands ["overrule1", "overrule0", "makePipe"]

