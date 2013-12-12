require 'spec_helper'
require 'user'
require 'post'

describe User do
	let(:user){User.new}
	let(:post){Post.new}
	before {
		post.content = "Hello World"
		if post.content != nil
			user.post_count = 1
		end
	}
	it "has the correct count of post" do
		user.post_count.should == 1
  	end
end