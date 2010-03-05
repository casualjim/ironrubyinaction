module Witty
  class ModelBase

    include WpfBehavior::Databinding
    include Witty::FeedParser
    extend Witty::FeedParser::ClassMethods
 
    attr_accessor :index, :is_new

    def initialize
      yield if block_given?
    end

    def ==(other)
      !!other && self.id == other.id
    end

    alias_method :equals, :==

  end
end  
