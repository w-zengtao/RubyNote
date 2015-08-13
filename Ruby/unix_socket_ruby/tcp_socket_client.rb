#!/usr/bin/env ruby

require 'socket'

s = TCPSocket.new 'localhost', 2000

while line = s.gets
  puts line
end

s.close