require 'spec_helper'
require 'profile'

describe Profile do
  let(:profile1){Profile.new(:first_name => "jim", :last_name => "jones", :country => "qatar", :username => "jimjones")}
  let(:profile2){Profile.new(:first_name => "john", :last_name => "jones", :country => "uae", :username => "johnjones")}

  it "should have a first name, last name, and a country of origin" do
  	profile1.first_name.should match(/^jim$/)
  	profile1.last_name.should match(/^jones$/)
  	profile1.country.should match(/^qatar$/)
  	profile2.first_name.should match(/^john$/)
  	profile2.last_name.should match(/^jones$/)
  	profile2.country.should match(/^uae$/)

  end
end
