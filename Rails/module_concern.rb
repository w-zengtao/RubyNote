#!/usr/bin/env ruby

# 典型的 module 定义
module M
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do 
      scope :disabled, -> { where(disabled: true) }
    end
  end
  
  module ClassMethods
    
  end
end

# ActiveSupport::Concern 的 module 定义 
require 'active_support/concern'

module M
  extend ActiveSupport::Concern
  
  included do 
    scope :disabled, -> { where(disabled: true) }
  end
  
  class_methods do 
    
  end
end

# -------------------------------------------- 这里是分割线 --------------------------------------------

# 下面这个例子就是 module Bar 依赖于 module Foo
module Foo
  def self.included(base)
    base.class_eval do 
      def self.method_injected_by_foo
      
      end
    end
  end
end

module Bar
  def self.included(base)
    base.method_injected_by_foo
  end
end

class Host
  include Foo
  include Bar
end

# ActiveSupport::Concern 解决依赖

module Foo
  extend ActiveSupport::Concern
  included do 
    def self.method_injected_by_foo
    end
  end
end

module Bar
  extend ActiveSupport::Concern
  include Foo
  
  included do
    self.method_injected_by_foo
  end
end

class Host
  include Bar
end