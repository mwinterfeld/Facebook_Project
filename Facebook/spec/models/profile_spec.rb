require 'spec_helper'
require 'profile'
require 'user'

describe Profile do
  let(:profile1){Profile.new(:first_name => "jim", :last_name => "jones", :country => "qatar", :username => "jimjones")}
  let(:profile2){Profile.new(:first_name => "john", :last_name => "jones", :country => "uae", :username => "johnjones")}
  let(:user){User.new}

  it "should have a first name, last name, and a country of origin" do
  	profile1.first_name.should match(/^jim$/)
  	profile1.last_name.should match(/^jones$/)
  	profile1.country.should match(/^qatar$/)
  	profile2.first_name.should match(/^john$/)
  	profile2.last_name.should match(/^jones$/)
  	profile2.country.should match(/^uae$/)

  end

  it "should be able to add a profile to a user" do
    user.profile = profile1
    user.profile.first_name.should match(/^jim$/)
    user.profile = profile2
    user.profile.first_name.should match(/^john$/)
  end

  it "should have ability to edit a profile"do
    user.profile = profile1
    user.profile.first_name = "something else"
    user.profile.last_name = "last name"
    user.profile.first_name.should match(/^something else$/)
    user.profile.last_name.should match(/^last name$/)
  end
end
