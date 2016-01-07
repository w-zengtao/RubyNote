#!/usr/bin/env ruby

module Mod
  def hello
    puts 'hello for module Mod'
  end
end

class Klass  
  def hello
    puts 'hello for class klass'
  end
end

k = Klass.new
k.hello
puts k
puts k.object_id
k.extend(Mod)
k.hello
puts k
puts k.object_id