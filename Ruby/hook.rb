#!/usr/bin/env ruby

require 'net/http'

class Net::HTTP
  def start_new
    puts 'before request'
    ans = start_old
    puts 'after request'
    ans
  end
  
  alias_method :start_old, :start
  alias_method :start, :start_new
end

# 这里就是一个 request 的 hook 探针

uri = URI('http://www.taobao.com')

Net::HTTP.start(uri.host, uri.port) do |http|
  request = Net::HTTP::Get.new uri
  @response = http.request request # Net::HTTPResponse object
end

puts @response