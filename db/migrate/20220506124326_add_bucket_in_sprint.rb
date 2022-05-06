class AddBucketInSprint < ActiveRecord::Migration[6.1]
  def change
    add_column :sprints, :bucket_id, :uuid, null: false
  end
end
