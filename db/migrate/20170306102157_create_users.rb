class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text   :website
      t.text   :intro
      t.string :password_digest # required by has_secure_password

      t.timestamps

      t.index :name
      t.index :email
    end
  end
end
