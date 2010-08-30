module InstanceCreator

  def build_instance_with_properties(klass,properties={})
    instance = klass.new
    properties.each do |k,v|
      if v.is_a?(Proc)
        instance.send(k) { v.call }
      else
        instance.send("#{k}=",v)
      end
    end
    instance
  end

end

WinF = System::Windows::Forms

class Magic
  include InstanceCreator

  class << self
    def build(&description)
      self.new.instance_eval(&description)
    end
  end

  def classify(string)
    string.gsub(/(^|_)(.)/) { $2.upcase } # simplified version of Rails inflector
  end

  def is_control?(parent, instance) 
    parent.respond_to?(:controls) && instance.respond_to?(:create_control)
  end

  def is_menu_item?(parent)
    parent.respond_to?(:menu_items)
  end

  def method_missing(method,*args)
    @stack ||= []
    parent = @stack.last
    clazz = Object.const_get(classify(method.to_s))
    instance = build_instance_with_properties(clazz, *args)

    if defined?(WinF::Control) or defined?(WinF::MenuItem)
      parent.controls.add(instance) if is_control?(parent, instance) 
      parent.menu_items.add(instance) if is_menu_item?(parent) 
    end
    @stack.push(instance)
    yield if block_given?
    @stack.pop
  end
end

