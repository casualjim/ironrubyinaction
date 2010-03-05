module Witty
  module XamlProxy

    # gets or sets the name of the view
    attr_accessor :view_name

    # gets the instance of the view
    attr_reader :view

    # gets the path to the view file
    attr_reader :view_path

    # loads the view into the view variable
    def load_view
      @view = XamlReader.load_from_path view_path if File.exists? view_path
      @view ||= view_name.to_s.gsub(/(.*::)+/, '').classify.new 
      @view
    end

    # returns the path to the file for the current view.
    # this is the file we'll be the proxy for
    def view_path
      @view_name ||= File.basename(self.class.to_s.gsub(/Proxy$/, '').underscore).to_sym
      path = "#{APP_ROOT}/views/#{view_name}.xaml"
      @view_path = path unless @view_path == path
      @view_path
    end

    def visibility=(visi)
      view.visibility = visi.to_sym.to_visibility if view.respond_to?(:visibility)
    end

    # shows the proxied view
    def show
      Witty::Application.current.has_main_window? ? view.show : view
    end

    def invoke(element, method, *args, &b)
      view.send(element.to_sym).send(method.to_sym, *args, &b)
    end

    def play_storyboard(storyboard_name)
      storyboard = view.resources[storyboard_name.to_s.to_clr_string]
      storyboard.begin view unless storyboard.nil?
    end

    def stop_storyboard(storyboard_name)
      storyboard = view.resources[storyboard_name.to_s.to_clr_string]
      storyboard.stop view unless storyboard.nil?
    end

    # tells this proxy to render itself with the changed information
    def refresh
      @view.refresh
    end

    def method_missing(sym, *args, &blk)
      # First we check if we can find a named control
      # When we can't find a control we'll check if we can find
      # a method on the view view by that name, if that is the
      # case we will call that method otherwise we'll return the control
      # if we found one. When no method or control could be found we
      # delegate to the default behavior
      obj = @view.find_name(sym.to_s.to_clr_string)
      nmsym = sym.to_s.camelize.to_sym
      if @view.respond_to?(nmsym) && obj.nil?
        @view.send sym, *args, &blk
      else
        obj.nil? ? super : obj
      end
    end

    def add_control(target, view)
      parent = send(target)
      vw = view.respond_to?(:view) ? view.view : view
      if parent.respond_to? :content=
        parent.content = vw
      elsif parent.respond_to? :children
        parent.children.add vw
      end
    end

    class << self

      # creates an instance of the view specified by the +view_name+
      def load(view_name)
        vw = new view_name.to_s
        vw.load_view
        vw
      end
    end

  end
end