#!/usr/bin/env ruby

module Mod
  def hello
    puts 'hello for module Mod'
  end
end

class Klass
  self.extend Mod
  
  def hello
    puts 'hello for class klass'
  end
end


k = Klass.new
k.hello
Klass.hello