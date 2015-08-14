#!/usr/bin/env ruby

require 'socket'

DEVIP = '172.16.0.139'
PORT = 80


# sockfd = TCPSocket.new DEVIP, PORT 就相当于下面两句话
sockfd = Socket.new Socket::AF_INET, Socket::SOCK_STREAM

# connect return 0 if successful
connect_status = sockfd.connect Socket.pack_sockaddr_in(PORT, DEVIP)

if connect_status != 0
  puts "connect error"
  close(sockfd)
  exit(1)
end

post_detail = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<Control attribute=\"Query\">
<DeviceInfo/>
</Control>"

post_string = "POST /xml HTTP/1.1
Content-Type:text/html
Host:#{DEVIP}:#{PORT}
Content-Length:#{post_detail.length + 1}

#{post_detail}

"

puts post_string

sockfd.send(post_string, 0)

puts 'now recving data'
puts sockfd.recvfrom(1024)