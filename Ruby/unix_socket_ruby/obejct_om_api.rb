#!/usr/bin/env ruby

require 'socket'

class OMSocket
  def initialize(ip_add, port)
    @ip_add = ip_add
    @port = port
  end

  def build_send_message
    #TODO

    post_detail = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<Control attribute=\"Query\">
<DeviceInfo/>
</Control>"

    post_string = "POST /xml HTTP/1.1
Content-Type:text/html
Host:#{@ip_add}:#{@port}
Content-Length:#{post_detail.length}

#{post_detail}
"
    return post_string
  end


  def run
    puts self.build_send_message

    TCPSocket.open(@ip_add, @port) do |socket|
      socket.send(self.build_send_message, 0)

      ans = socket.read

      puts ans
    end
  end

end

OMSocket.new('172.16.0.139', 80).run
