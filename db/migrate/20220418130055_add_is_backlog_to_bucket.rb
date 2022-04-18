class AddIsBacklogToBucket < ActiveRecord::Migration[6.1]
  def change
    add_column :buckets, :is_backlog, :boolean, default: false
  end
end
