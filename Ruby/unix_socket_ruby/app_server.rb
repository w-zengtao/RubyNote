#!/usr/bin/env ruby


# nginx -c /tmp/nginx.conf

require "socket"

# Create the socket and 'save it' to the file system
server = UNIXServer.new('/tmp/socktest.sock')

# Wait untill for a connection (by nginx)
socket = server.accept

# Read everything from the socket

while line = socket.readline
  puts line.inspect
end

socket.close