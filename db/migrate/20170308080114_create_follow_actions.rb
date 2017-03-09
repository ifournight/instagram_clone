class CreateFollowActions < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_actions do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps

      t.index :follower_id
      t.index :followed_id
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
