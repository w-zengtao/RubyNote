# N + 1
# 

clients = Client.includes(:address).limit(10)

clients.each do |client|
  puts client.address.postcode
end

# 所以下面仅仅只有两次查询
SELECT * FROM clients LIMIT 10
SELECT addresses.* FROM addresseses
  WHERE (addresseses.client_id IN (1, 2, 3 ,4 ,5 ,6 ,7, 8, 9, 10))


# 分类
class Category < ActiveRecord::Base
  has_many :posts
end

# 文章
class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  has_many :tags
end

# 评论
class Comment < ActiveRecord::Base
  belongs_to :post
  has_one :guest
end

class Guest < ActiveRecord::Base
  belongs_to :comment
end

class Tag < ActiveRecord::Base
  belongs_to :post
end

# 数组指定多个关联

Post.includes(:category, :comments)

# 获取ID为1的分类 并按需加载所有关联的文章，文章的标签和评论，以及每个评论的guest关联
# Hash指定嵌套关联

Category.includes(posts: [{ comments: :guest}, :tags]).find(1)