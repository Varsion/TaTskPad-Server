class AddOrgIdAndRoleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :organization_id, :uuid
    add_column :users, :is_owner, :boolean, default: false
  end
end
