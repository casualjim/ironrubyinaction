require 'listing1.15.rb'
require 'listing1.16.rb'

printables = [HelloWorld.new, Book.new("IronRuby In Action")]

printables.each do |printable|
	#if you absolutely need to be sure it will behave correctly
    fail NoMethodError.new("We expect the method print to be on the object <<printable>>") unless printable.respond_to?(:print)
	puts printable.print
end
