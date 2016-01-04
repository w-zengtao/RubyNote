#!/usr/bin/env ruby

module X
  def test
    puts 'Module self call test'
  end

  module_function :test

  def self.included(base)
    base.extend ClassMethods

    base.class_eval do
      def tatata
        puts 'tatata'
      end
    end
  end

  module ClassMethods
    def cl
      puts '-' * 10
      puts 'this is class methods'
    end
  end
end

X.test


class Abc
  include X

  def he
    puts '-' * 10
    print 'class Abc call module test and '
    test
  end
end


Abc.new.he
Abc.new.tatata
Abc.cl

Abc.instance_eval do
  def ins
    puts 'ins'
  end
end

Abc.ins

Abc.class_eval do
  def cla
    puts 'cla'
  end
end

Abc.new.cla

abc = Abc.new
class << abc
  def abc_eigenclass
    puts 'abc_eigenclass'
  end
end

abc.abc_eigenclass
