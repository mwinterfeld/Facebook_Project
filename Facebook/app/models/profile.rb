class Profile < ActiveRecord::Base
  attr_accessible :city, :country, :first_name, :last_name, :interests, :user_id, :username
  serialize :interests
  belongs_to :user
  def user
    User.find(self.user_id)
  end
end
