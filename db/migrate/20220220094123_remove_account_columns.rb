class RemoveAccountColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :organization_id
    remove_column :accounts, :is_owner
  end
end
