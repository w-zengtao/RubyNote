class Ghee
  class ResourceProxy
    def method_mission(message, *args, &block)
      # message 其实就是 method_name
      subject.send(message, *args, &block)
    end

    def subject
      @subject ||= connection.get(path_prefix) { |req| req.params.merge!params }.body
    end
  end
end

class Ghee
  module API
    module Gists
      class Proxy < ::Ghee::ResourceProxy
        def star
          connection.put("#{path_prefix}/star").status == 204
        end
      end
    end
  end
end