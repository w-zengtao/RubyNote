#!/usr/bin/env ruby
#

ary = %w(p bc de)

ary1 = ary.sort do |i, j|
  i.size <=> j.size
end

# ary1 p bc de

ary2 = ary.sort do |i, j|
  i <=> j
end

# ary2 bc de p

# 综合上述 block在这里可以理解为 函数(sort)的一个高阶参数
# 


def method_with_block
  yield
end

method_with_block do 
  puts 'call me'
end

def method_with_block_parameter
  n = 'windy'
  yield(n)
end

method_with_block_parameter do |i|
  puts 'call me ' + i
end
# call me windy

def method_with_param(p)
  yield(p)
end

method_with_param('test') do |i|
  puts 'call me ' + i
end
# call me test
# 

size_code = Proc.new do |i , j|
  i.size <=> j.size
end

ary.sort(&size_code)
# &符号 指代这是一个 “高阶参数” block like匿名的Proc

### lambda vs Proc
#
def methods(&code)
  code.call
  puts 'methods end'
end

a_proc = Proc.new do 
  puts "call Proc"
  # return 
  next
end

a_lambda = lambda do 
  puts 'call lambda' 
  return
end

methods(&a_proc) #call Proc ; methods end Proc相当于闭包 保留了当时定义代码块的上下文环境
methods(&a_lambda) #call lambda; methods end

def go
  a = Proc.new do 
    puts 'Proc'

    return
  end

  methods(&a)

  puts 'end go'
end

def methods(&a)
  puts "methods"
  a.call

  puts "end methods"
end

go # methods; Proc

# lambda 像是一个完整的方法（只不过是匿名的）return的时候会从自己返回
# Proc 则像是一个过程 无依无靠 
# 
# 然后lambda 只是Proc的一个特殊实例

















