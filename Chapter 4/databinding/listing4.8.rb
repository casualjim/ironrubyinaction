require 'System'
require 'WindowsBase'
require 'PresentationCore'
require 'PresentationFramework'
require 'System.Windows.Forms'

include System
include System::Windows
include System::Collections::ObjectModel

xaml = <<-XAML

<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" 
  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
  Height="400"
  Width="400"
  Title="Databinding test"
  >
  
  <StackPanel >
    <ListView x:Name="people_list" ItemsSource="{Binding people}">	
      <ListView.View>
        <GridView>
          <GridViewColumn Width="140" Header="Name" 
            DisplayMemberBinding="{Binding name}" />	
          <GridViewColumn Width="140" Header="Age"  
            DisplayMemberBinding="{Binding age}" />
        </GridView>
      </ListView.View>
    </ListView>
      <TextBox x:Name="tb_new_name" Text="{Binding new_name}" />	
        <Button x:Name="change_name" Content="Click Me!" />
    </StackPanel>
</Window>

XAML

module WpfBehavior

  module Databinding

    module ClassMethods

      # defines a write-only attribute on an object
      # this would map to a property setter in different languages
      def attr_writer(*names)
        names.each do |nm|
          mn = nm         
          self.send :define_method, "#{nm}=".to_sym do |arg|
            __vr__ =  instance_variable_get :"@#{mn}"
            return __vr__ if __vr__ == arg
            instance_variable_set :"@#{mn}", arg
            raise_property_changed mn
          end
        end
      end

      # defines a read/write attribute on an object.
      # this would map to a property with a getter and a setter in different langauages
      def attr_accessor(*names)
        attr_reader *names
        attr_writer *names
      end


    end

    # extend the class with the class methods defined in this module
    def self.included(base)
      unless base.ancestors.include? System::ComponentModel::INotifyPropertyChanged
        base.send :include, System::ComponentModel::INotifyPropertyChanged 
      end
      base.extend ClassMethods
    end

    def add_PropertyChanged(handler=nil)
      @__handlers__ ||= []
      @__handlers__ << handler
    end

    def remove_PropertyChanged(handler=nil)
      @__handlers__ ||= []
      @__handlers__.delete handler
    end

    private
    def raise_property_changed(name)
      return unless @__handlers__
      @__handlers__.each do |ev|
        ev.invoke self, System::ComponentModel::PropertyChangedEventArgs.new(name) if ev.respond_to? :invoke
        ev.call self, System::ComponentModel::PropertyChangedEventArgs.new(name) if ev.respond_to? :call
      end
    end

  end

end

class Person

  include WpfBehavior::Databinding

  attr_accessor :name, :age

  def to_s
    "<Person name=#{self.name}, age=#{age} />"
  end

  def initialize(attrs={})
    attrs.each do |k, v|
      self.send :"#{k}=", v
    end
  end
end  #Person

class ViewModel

  include WpfBehavior::Databinding

  attr_accessor :people, :new_name	

end #ViewModel

if $0 == __FILE__
  
  vm = ViewModel.new    
  vm.people=  ObservableCollection.of(Person).new	
  [
    Person.new( :name => "Ivan", :age => 32), 
    Person.new(:name => "Adam", :age => 27), 
    Person.new(:name => "Maurits", :age => 31)
  ].each { |p| vm.people.add p }
  
  window = Markup::XamlReader.parse(xaml)	
  btn = window.find_name("change_name")
  btn.click do |s, a|
    vm.people.first.name = vm.new_name
  end
  
  window.data_context = vm
  Application.new.run window	
end
