#!/usr/bin/env ruby

module ClassMethods
  def cmethod
    "class method"
  end
end

module InstanceMethods
  def imethod
    "instance method"
  end
end

class MyClass
  extend ClassMethods
  include InstanceMethods
end

p MyClass.cmethod
p MyClass.new.imethod