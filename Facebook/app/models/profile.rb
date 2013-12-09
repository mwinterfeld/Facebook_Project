class Profile < ActiveRecord::Base
  attr_accessible :city, :country, :first_name, :last_name
  serialize :interests
  belongs_to :user
end
