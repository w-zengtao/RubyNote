#!/usr/bin/env ruby

require 'socket'

server = TCPServer.new "localhost", 2000

loop do 
  client = server.accept
  client.puts "Hello !"
  client.puts "Time is #{Time.now}"
  client.puts "test 3"

  puts 'hahahah'
  client.close
end