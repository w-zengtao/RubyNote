eigenclass 只是对于 类的实例而言的 
```
    str = String.new
    class << str
        def hello
            puts 'this is str\'s eigenclass'
        end
    end
```

```
module Edition
    def edition(n)
        puts "#{self} #{n}"
    end
end
str = 'abc'
str.extend(Edition) # 可以批量扩展单例方法
str.edition(5)
```

##### 类方法其实就是Class类的实例方法 也是类对象的单例方法