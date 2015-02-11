#!/usr/bin/env ruby

# define_method allows you to decide the name of the defined method at runtime

class MyClass
  define_method :my_method do |my_arg|
    puts my_arg * 3
  end
end

MyClass.new.my_method(2)