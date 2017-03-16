class CreateLikeActions < ActiveRecord::Migration[5.0]
  def change
    create_table :like_actions do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false

      t.timestamps

      t.index :user_id
      t.index :post_id
      t.index [:user_id, :post_id]
    end
  end
end
