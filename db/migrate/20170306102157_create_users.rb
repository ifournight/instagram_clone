class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: ''

      t.timestamps

      t.index :name, unique: true
    end
  end
end
