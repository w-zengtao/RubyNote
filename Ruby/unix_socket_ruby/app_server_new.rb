#!/usr/bin/env ruby

require "socket"

# Connection creates the socket and accepts new connections

class Connection
  attr_accessor :path
  
  def initialize(path:)
    @path = path
    File.unlink(path) if File.exists?(path)
  end
  
  def server
    @server ||= UNIXServer.new(@path)
  end
  
  def on_request
    socket = server.accept
    yield(socket)
    socket.close
  end
end

# AppServer logs incoming requests and renders a view in response

class AppServer
  attr_reader :connection
  attr_reader :view
  
  def initialize(connection:, view:)
    @connection = connection
    @view = view
  end
  
  def run
    while true
      connection.on_request do |socket|
        while (line = socket.readline) != "\r\n"
          puts line
        end
        socket.write(view.render)
      end
    end
  end
end

# TimeView simply provides the HTTP response

class TimeView
  def render
    %[HTTP/1.1 200 OK 

      The current timestamp is: #{ Time.now }
    ]
  end
end


AppServer.new(connection: Connection.new(path: '/tmp/socktest.sock'), view: TimeView.new).run