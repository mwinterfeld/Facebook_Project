class AddUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :integer, :string
    #change_column :posts, :user_id, :integer
    #change_column :posts, :integer, :string
  end
end
