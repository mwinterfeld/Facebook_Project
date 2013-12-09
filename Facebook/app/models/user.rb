class User < ActiveRecord::Base
  attr_accessible :friend_count, :id, :post_count, :username, :password
  serialize :friends
  attr_accessible :friends 
  has_one :profile
  has_many :posts
end
