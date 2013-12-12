require "spec_helper"
require "post"
require "user"

describe Post do
	let(:post){Post.new}
	let(:post1){Post.new(:content => "mary had a little lamb")}
	let(:post2){Post.new(:content => "uno dos tres")}
	let(:post3){Post.new(:content => "it wont throw an error right?")}
	let(:post4){Post.new(:content => "of course it will throw an error")}
	let(:user){User.new(:posts => [], :post_count => 0)}

	it "has a content that matches the content" do
		post.content = "Hello World"
  		post.content.should == "Hello World"
  	end

  	it "can be added to a user" do
  		post.content = "a post"
  		user.add_post(post.content)
  		array = []
  		user.posts.each do |x|
  			array << x[:content]
  		end
  		array.should include(post.content)
  	end

  	it "should keep track of post number when you add posts" do
  		user.add_post(post1.content)
  		user.add_post(post2.content)
  		user.add_post(post3.content)
  		user.add_post(post4.content)

  		user.post_count.should equal(4)
  	end
end