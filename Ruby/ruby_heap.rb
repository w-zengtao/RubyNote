#!/usr/bin/env ruby

class Heap < Array  # max
  def heap_size

  end

#  位操作来实现 2i 或者 i／2是特别快
  def parent i
    at((i + 1) / 2 - 1)
  end

  def left i 
    at((i + 1) * 2 - 1)
  end

  def right i
    at((i + 1) * 2)
  end 
end



puts ary = Heap.new([16, 14, 10, 8, 7, 9, 3, 2, 4, 1])

puts ary.parent(4)
