# eg  关于SQL的 join 可以参看这里 http://www.w3school.com.cn/sql/sql_join.asp
# 

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

# 这里是分割线

# 使用 文章的分类 创建 分类对象 （连接单个关联）
Category.joins(:posts)
SELECT categories.* FROM categories 
  INNER JOIN posts ON posts.category_id = categories.id

# 返回指定分类且至少有一个评论的所有文章 （连接多个关联）
Post.joins(:category, :comments)
SELECT posts.* FROM posts
  INNER JOIN categories ON posts.category_id = categories.id
  INNER JOIN comments ON comments.post_id = posts.id

# 返回有一个游客发布评论的所有文章 (连接一层嵌套关联)
Post.joins(comments: :guest)
SELECT posts.* FROM posts
  INNER JOIN comments ON comments.post_id = posts.id
  INNER JOIN guests ON guests.comment_id = comments.id
