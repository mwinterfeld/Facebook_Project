class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :id
      t.string :content
      t.string :timestamp
      t.integer :is_comment
      t.integer :likes_count
      t.integer :dislikes_count

      t.timestamps
    end
  end
end
