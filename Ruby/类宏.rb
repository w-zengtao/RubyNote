#!/usr/bin/env ruby

module MyModule
  
  def self.included(base)
    base.extend ClassMethods
    
    base.class_eval do 
      def my_instance_method
        
      end
    end
  end
  
  module ClassMethods
    def my_attr(str)
      
      define_method(str) do
        @str
      end 
      
      define_method("#{str}=") do |value| # |*args, &block|
        @str = value
      end
    end
  end
end

class MyClass
  include MyModule
  
  my_attr :abc
end
obj = MyClass.new
# obj.abc = '10'
# puts obj.abc

puts MyClass.instance_methods
