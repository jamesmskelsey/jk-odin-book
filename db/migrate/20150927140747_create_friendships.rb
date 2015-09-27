class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string  :status # can be "pending", "accepted", "denied"

      t.timestamps null: false
    end
  end
end
