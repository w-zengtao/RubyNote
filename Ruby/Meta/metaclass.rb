#!/usr/bin/env ruby

class Object
  def metaclass
    class << self
      self
    end
  end

  def meta_eval &blk
    metaclass.instance_eval &blk
  end

  # String.instance_eval &blk

  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end

  def class_def name, &blk
    class_eval { define_method name, &blk }
  end
end

puts String.metaclass #<Class:String>

puts String.new.metaclass

String.meta_def :zengtao do |a, b|
  "here is a blk " + a + ' ' + b
end

puts String.zengtao 'aaa', 'bbb'

str = String.new

str.meta_def :zengtao_abc do 
  "here is zengtao - abc"
end

puts str.zengtao_abc