require 'hello_world'
require 'book'

printables = [HelloWorld.new, Book.new("IronRuby In Action")]

printables.each do |printable|
	#if you absolutely need to be sure it will behave correctly
    unless printable.respond_to?(:print)
      fail NoMethodError.new("We expect the method print to be on the object <<printable>>") 
    end
	puts printable.print
end
