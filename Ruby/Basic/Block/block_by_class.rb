#!/usr/bin/env ruby

# 下面其实就是将 块 封装 成为了 类 Proc类

hello = Proc.new do |name|
  puts "Hello, #{name}"
end

hello.call('ruby')

#在定义方法的时候 如果末尾的参数使用 "&参数名"

def total2(from, to, &block)
  result = 0
  from.upto(to) do |num|
    if block
      result += block.call(num)
    else
      result += num
    end
  end
  return result
end

puts total2(1,10) { |num| num ** 2 }