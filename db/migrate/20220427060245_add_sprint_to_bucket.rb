class AddSprintToBucket < ActiveRecord::Migration[6.1]
  def change
    add_column :buckets, :sprint_id, :uuid, null: true
  end
end
