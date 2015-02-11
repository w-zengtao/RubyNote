#!/usr/bin/env ruby

require 'pry'

pry = Pry.new

puts Pry.methods.grep(/attr/)
