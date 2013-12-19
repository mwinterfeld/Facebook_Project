class AddWallPostsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wall_posts, :text
  end
end
