class ConnectBucketToIssue < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :bucket_id, :uuid, null: true
  end
end
