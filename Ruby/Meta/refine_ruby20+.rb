#!/usr/bin/env ruby

module StringExtensions
  refine String do
    def reverse
      'esrsver'
    end
  end
end

module StringStuff
  using StringExtensions
  puts 'my_string'.reverse
end

puts 'my_string'.reverse

class MyClass
  def my_method
    'original my_method()'
  end

  def another_method
    my_method
  end
end

module MyClassRefinement
  refine MyClass do 
    def my_method
      'refine my_method()'
    end
  end
end

using MyClassRefinement
puts MyClass.new.my_method

puts MyClass.new.another_method