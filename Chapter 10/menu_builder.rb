class MainMenu
  class << self
    def build(&script)
      instance = self.new
      instance.instance_eval(&script)
      instance
    end
  end

  def item(label,click_handler=nil)
    @parents ||= [self]
    @parents.push(@parents.last.menu_items.add(label))
    @parents.last.click { click_handler.call } if click_handler
    yield if block_given?
    @parents.pop
  end  
end

