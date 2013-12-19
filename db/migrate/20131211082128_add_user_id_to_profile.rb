class AddUserIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :user_id, :integer
    add_column :profiles, :integer, :string
  end
end
