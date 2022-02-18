class AddOrgIdAndRoleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :organization_id, :uuid
    add_column :accounts, :is_owner, :boolean, default: false
  end
end
