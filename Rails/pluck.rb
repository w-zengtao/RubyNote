# 和 select 方法不一样，pluck 直接把查询结果转换成 Ruby 数组，不生成 Active Record 对象
# 但 pluck 方法不会使用重新定义的属性方法处理查询结果
# 
class Client < ActiveRecord::Base
  def name
    "I am #{super}"
  end
end

Client.select(:name).map &:name # => ["I am David", "I am Jeremy", "I am Jose"]

Client.pluck(:name) # => ["David", "Jeremy", "Jose"]


# ids 方法可以直接获得数据表的主键