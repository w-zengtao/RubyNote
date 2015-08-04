#!/usr/bin/env ruby
#

#
# unix socket 使得一个进程通过类似文件的方式与另外一个进程通信 IPC的一种
require 'socket'

server = UNIXServer.new('/tmp/simple.sock')

puts '===Waiting for connection'

socket = server.accept

puts '===Got Request:'

puts socket.readline

puts "=== Sending Response"

socket.write("I read you loud and clear, good buddy!")

socket.close