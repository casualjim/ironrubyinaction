APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))
$:.unshift APP_ROOT + "/lib"
$:.unshift File.join(APP_ROOT, "bin")
$:.unshift File.join(APP_ROOT, "lib", "witty", "converters")

require 'System'
require 'WindowsBase'
require 'PresentationCore'
require 'PresentationFramework'
require 'System.Windows.Forms'
require 'System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'System.Web, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'
require 'WindowsBase, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'PresentationFramework.Aero, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'System.Net, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'
require 'System.ServiceModel.Web, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'System.Windows.Presentation, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'UIAutomationProvider, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'System.Security, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

require 'Witty.Controls.dll'

lst = System::Collections::Generic::List.of(System::String).new
$:.each {|pth| lst.add pth.to_clr_string }
Witty::Controls::RubyConverterExtension.load_paths = lst

require 'witty/constants'
require 'witty/core_ext'

%w(
  System
  System::Net
  System::Xml
  System::IO
  System::Web
  System::Text
  System::Threading
  System::Windows
  System::Windows::Threading
  System::Windows::Data
  System::Windows::Markup
  System::Collections::ObjectModel
  Witty
  Witty::Controls
).each { |ns| Object.send :include, eval(ns) }

require 'witty/databinding'
require 'witty/secure_string'
require 'witty/iron_xml'
require 'witty/web_client'
require 'witty/feed_parser'
require 'witty/snipr_url'
require 'witty/xaml_proxy'

require 'witty/models/model_base'
require 'witty/models/tweet_base'

Dir[APP_ROOT + '/lib/witty/models/*.rb'].each { |file| require file.gsub(/#{APP_ROOT}\/lib/, '') }

require 'witty/login_control_proxy'
require 'witty/main_window_proxy'


module Witty

  class Application < ::System::Windows::Application
    def initialize(&b)
      window = instance_eval(&b) if b
      run window.view
    end

    def has_main_window?
      @main_window.nil?
    end

    def set_skin(name)
      self.resources.merged_dictionaries.add load_skin(name)
    end

    # Helper method for file references.
    # root_path("config", "settings.yml")
    def root_path(*args)
      File.join(APP_ROOT, *args)
    end

    # Returns the full path to the assets folder along with any given additions
    # assets_path("images")
    def assets_path(*args)
      root_path('assets', *args)
    end

    # Returns the full path to the assets folder along with any given additions
    # assets_path("images")
    def skins_path(*args)
      assets_path('skins', *args)
    end


    def load_skin(name=:default)
      XamlReader.load_from_path skins_path("#{name}.xaml")
    end
  end
end

if $0 == __FILE__
  Witty::Application.new do
    set_skin :aero
    MainWindowProxy.new
  end
end


