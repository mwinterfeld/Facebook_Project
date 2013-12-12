require "spec_helper"
require "post"
require "user"

describe Post do
	let(:post){Post.new}
	let(:user){User.new}
	before {post.content = "Hello World"}

	it "has a content that matches the content" do
  		post.content.should == "Hello World"
  	end
end