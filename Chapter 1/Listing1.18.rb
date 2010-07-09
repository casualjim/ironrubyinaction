require 'hello_world'
require 'book'

printables = [HelloWorld.new, Book.new("IronRuby In Action")]

printables.each do |printable|	
	#the wrong way to do it is to use ruby as a statically typed language
    unless printable.is_a? Printable
      fail TypeError.new("#{printable.class} doesn't implement Printable") 
    end
	puts printable.print 
end
