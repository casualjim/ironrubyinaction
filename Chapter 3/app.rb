include System::Windows 
include System::Windows::Controls 

Application.current.load_root_visual Canvas.new, "app.xaml"
xaml.find_name('textblock').Text = 'Hello world from IronRuby'
