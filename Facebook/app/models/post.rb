class Post < ActiveRecord::Base
  attr_accessible :content, :dislikes_count, :id, :is_comment, :likes_count, :user_id
  belongs_to:user
end
