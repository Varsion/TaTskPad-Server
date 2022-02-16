class CreateUser < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password
      t.text :token
      t.string :email_verify
      t.integer :role
      t.timestamps
    end
  end
end
