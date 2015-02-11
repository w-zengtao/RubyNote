#!/usr/bin/env ruby

class C
  def public_method
    puts self
    self.private_method
  end

  private

  def private_method
    puts 'a' * 10
  end
end

c = C.new
puts c
c.public_method