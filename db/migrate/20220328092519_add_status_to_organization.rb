class AddStatusToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :organizations, :status, :string, default: "active"
  end
end
