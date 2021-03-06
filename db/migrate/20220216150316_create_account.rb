class CreateAccount < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :token
      t.string :verify_code
      t.boolean :verified, default: false
      t.integer :role
      t.timestamps
    end
  end
end
