#!/usr/bin/env ruby

require "socket"

socket = UNIXSocket.new('/tmp/simple.sock')

puts "=== Sending"

socket.write("Hello server, can you hear me?\n")

puts "=== Getting Response"
puts socket.readline

socket.close