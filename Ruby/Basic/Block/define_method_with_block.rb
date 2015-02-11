#!/usr/bin/env ruby

def total(from, to)
  res = 0
  from.upto(to) do |num|
    if block_given?
      res += yield(num)
    else
      res += num
    end
  end
  return res
end

puts total(5, 10)
puts total(1, 10) { |num| num ** 2 }