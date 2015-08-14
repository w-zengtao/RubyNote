#!/usr/bin/env ruby

require 'socket'

DEVIP = '172.16.0.139'
PORT = 80

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

TCPSocket.open(DEVIP, PORT) do |socket|
  socket.send(post_string, 0)
  puts socket.read
end