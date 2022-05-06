class DeleteSprintInBucket < ActiveRecord::Migration[6.1]
  def change
    remove_column :buckets, :sprint_id
  end
end
