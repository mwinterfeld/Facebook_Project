class User < ActiveRecord::Base
  attr_accessible :friend_count, :id, :post_count, :username, :password
  serialize :friends
end
