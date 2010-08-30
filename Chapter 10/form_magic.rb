$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'magic'
require 'menu_builder'

form = Magic.build do
  form(:text => "Hello") do
    flow_layout_panel(:dock => DockStyle.fill) do
      button(:text => "Click me!", :click => lambda { MessageBox.Show("Hello") })
      button(:text => "Quit", :click => lambda { Application.Exit })
    end
  end
end

form.menu = MainMenu.build do
  item("&File") {
    item("&Quit").click { Application.Exit }
  }
end

Application.run(form)

