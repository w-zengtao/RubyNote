#!/usr/bin/env ruby

module Printable
  def print
    puts 'Printable::print'
  end

  def prepare_cover
    puts 'Printable::prepare_cover'
  end
end

module Document
  def print_to_screen
    prepare_cover
    format_for_screen
    print
  end

  def format_for_screen
    puts "Document::format_for_screen"
  end

  def print
    puts "Document::print"
  end
end

class Book
  include Document
  include Printable
end

b = Book.new
b.print_to_screen
puts '-' * 40
puts Book.ancestors