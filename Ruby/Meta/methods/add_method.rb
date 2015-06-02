def addMethod(m, &block)
  self.class.send(:define_method, m , &block)
end

class String
  remove_method()
end