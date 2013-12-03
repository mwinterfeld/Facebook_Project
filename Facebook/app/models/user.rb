class User < ActiveRecord::Base
  attr_accessible :friend_count, :id, :post_count
  serialize :friends
end
