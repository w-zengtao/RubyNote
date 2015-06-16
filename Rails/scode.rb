class Post < ActiveRecord::Base
  scope :published, -> { where(published: true) }

  # 两个的意思是一样的
  def self.published
    where(published: true)
  end

  # 作用域可以链在一起调用
  
  scope :published_and_commented, -> {
    published.where("comments_count > 0")
  }

  # 传入参数
  #
  scope :created_before, ->(time) { where( "created_at < ?", time ) }


  scope :active, -> { where state: 'active' }
  scope :inactive, -> { where state: 'inactive' }
  default_scope { where state: 'pending' }
end

Post.created_before(Time.zone.now)

# 合并作用域
Post.active.inactive 

Post.active.where(state: 'finished')