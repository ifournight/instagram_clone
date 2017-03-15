class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content, default: '', null: false
      t.integer :user_id
      t.integer :post_id

      t.timestamps

      t.index :user_id
      t.index :post_id
    end
  end
end
