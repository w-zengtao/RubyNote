#!/usr/bin/env ruby

def myloop
  while true
    yield
  end
end

num = 1
myloop do 
  puts num
  break if num > 100
  num *= 2
end