class AddIsReleaseToBucket < ActiveRecord::Migration[6.1]
  def change
    add_column :buckets, :is_release, :boolean, default: false
  end
end
