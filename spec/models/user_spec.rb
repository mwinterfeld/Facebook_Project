require 'spec_helper'
require 'user'
require 'post'

describe User do
	let(:user1){User.new(:friends => {},:posts=> [])}
	let(:user2){User.new(:friends => {})}
	let(:post1){Post.new(:content => "Hello world!")}
	let(:post2){Post.new(:content => "Welocome to Planet earth!")}

	it "has the correct count of post" do
                user1.add_post(post1.content)
                user1.add_post(post2.content)
		user1.post_count.should == 2
  	end

  	before {
  		user1.username = "jimjones"
  		user2.username = "johnjones"
  	}
  	it "should be able to send a friend request" do
  		user2.requesting(user1.username)
  		user1.pending(user2.username)

  		user2.friends.keys.should include(user1.username.to_sym)
  		user1.friends.keys.should include(user2.username.to_sym)
  		user2.friends.values.should include("requesting")
  		user1.friends.values.should include("pending")
  	end

  	it "should be able to accept friend request" do
  		user1.add_friend(user2.username)
  		user2.add_friend(user1.username)

  		user1.friends.values.should include("friend")
 		user2.friends.values.should include("friend")

  	end
end
