#!/usr/bin/env ruby
# hash default_scope是怎么做到无限级的默认值是{}来的

l = lambda { |h, k| h[k] = Hash.new(&l) }

h = Hash.new(&l)