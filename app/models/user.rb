class User < ActiveRecord::Base
  attr_accessible :friend_count, :id, :post_count, :username, :password, :user_id
  serialize :friends
  attr_accessible :friends 
  serialize :wall_posts
  attr_accessible :wall_posts
  has_one :profile
  has_many :posts
  attr_accessible :posts

  def requesting(username)
  	self.friends << [username, "requesting"]
  	self.save
  end

  def pending(username)
  	self.friends << [username, "pending"]
  	self.save
  end

  def add_friend(username)
  	self.friends.each do |array|
      if(array[0] == username)
        array[1] = "friend"
      end
    end
  	self.increment!(:friend_count)
  	self.save
  end

  def remove_friend(username)
    self.friends.delete(["#{username}", "friend"])
    self.decrement!(:friend_count)
    self.save
  end

  def add_post(post_content)
    profile = Profile.find(self.id)
    post = Post.new(:content => "#{post_content}", :likes_count => 0, :dislikes_count => 0, :is_comment => 0, :username => profile.first_name.capitalize + " " + profile.last_name.capitalize)
    self.posts << post
    self.increment!(:post_count)
    self.save
  end

   def add_wall_post(post_content, wall_id, poster_id)
    user = User.find(wall_id)
    poster = Profile.find_by_user_id(poster_id)
    post = Post.new(:content => "#{post_content}", :likes_count => 0, :dislikes_count => 0, :is_comment => 0, :username => poster.first_name.capitalize + " " + poster.last_name.capitalize, :user_id => poster_id)
    if(!user.wall_posts) then
      user.wall_posts = []
    end
    user.wall_posts << post
    user.save
  end

  def add_comment(post_content)
    post = Post.new(:content => "#{post_content}", :likes_count => 0, :dislikes_count => 0, :is_comment => 1)
    self.posts << post
    self.increment!(:post_count)
    self.save
  end

end
