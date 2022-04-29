class AddKeyNumberToIssue < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :key_number, :string, null: false, unique: true
  end
end
