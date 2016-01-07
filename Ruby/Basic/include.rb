#!/usr/bin/env ruby

module Mod
  def hello
    puts 'Mod\'s hello'
  end
  
  class << self
    def included(base)
      def base.call
        puts 'base call'
      end
      
      base.extend ClassMethods
    end
  end
  
  module ClassMethods
    def hi
      puts 'hi'
    end
  end
end


class Test
  include Mod
end

Test.hi
Test.call
Test.new.hello