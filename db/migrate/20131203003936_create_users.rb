class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.integer :post_count
      t.integer :friend_count
      t.string :friends
      t.string :username
      t.string :password
      t.timestamps
    end
  end
end
