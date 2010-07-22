require 'System'
require 'WindowsBase'
require 'PresentationCore'
require 'PresentationFramework'
require 'System.Windows.Forms'

include System
include System::Windows
include System::Collections::ObjectModel
include System::ComponentModel

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

class Person

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
  
  window = Markup::XamlReader.parse(xaml.to_clr_string)	
  btn = window.find_name("change_name")
  btn.click do |s, a|
    vm.people.first.name = vm.new_name
  end
  
  window.data_context = vm
  Application.new.run window	
end
