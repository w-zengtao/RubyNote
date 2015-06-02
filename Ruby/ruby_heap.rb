#!/usr/bin/env ruby

class Heap < Array  # max

  def heap_size
    length
  end

  # 对i递归使得i为root的数组部分符合堆结构
  def max_heapify i
    l, r  = left(i), right(i)
    lar = l
    if (l <= heap_size) && (at(l) > at(i))

    else
      lar = i
    end

    if (r <= heap_size - 1) && (at(r) > at(lar))
      lar = r
    end

    if lar != i
      self[i] = (self[i] + self[lar])
      self[lar] = (self[i] - self[lar])
      self[i] = (self[i] - self[lar])

      max_heapify(lar)
    end
  end

  def build_max_heap

    i = (length-1) /2 
    while i >= 0 
      max_heapify i 
      i -= 1
    end
  end

  #  位操作来实现 2i 或者 i／2是特别快
  def parent i
    (i + 1) / 2 - 1
  end

  def left i 
    (i + 1) * 2 - 1
  end

  def right i
    (i + 1) * 2
  end 
end

ary = Heap.new([4, 1, 3, 2, 16, 9, 10, 14, 8, 7])

ary.build_max_heap

puts ary