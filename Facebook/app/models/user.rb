class User < ActiveRecord::Base
  attr_accessible :friend_count, :id, :post_count, :username, :password, :user_id
  serialize :friends
  attr_accessible :friends 
  has_one :profile
  has_many :posts
  attr_accessible :posts

  def requesting(username)
  	self.friends[username.to_sym] = "requesting"
  	self.save
  end

  def pending(username)
  	self.friends[username.to_sym] = "pending"
  	self.save
  end

  def add_friend(username)
  	self.friends[username.to_sym] = "friend"
  	self.increment!(:friend_count)
  	self.save
  end

  def add_post(post_content)
    post = Post.new(:content => "#{post_content}", :likes_count => 0, :dislikes_count => 0, :is_comment => 0)
    self.posts << post
    self.increment!(:post_count)
    self.save
  end

  def add_comment(post_content)
    post = Post.new(:content => "#{post_content}", :likes_count => 0, :dislikes_count => 0, :is_comment => 1)
    self.posts << post
    self.increment!(:post_count)
    self.save
  end

end
