#!/usr/bin/env ruby

class Array
  def qsort
    size < 2 ? self : partition { |x|
      x <= (self-[max]).max
    }.map(&:qsort).inject(:+)
  end
end

puts (1..100).to_a.shuffle.qsort