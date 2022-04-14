class CreateBucket < ActiveRecord::Migration[6.1]
  def change
    create_table :buckets, id: :uuid  do |t|
      t.string :name
      t.string :description
      t.belongs_to :project, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
