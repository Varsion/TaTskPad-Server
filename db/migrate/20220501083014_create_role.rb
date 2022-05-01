class CreateRole < ActiveRecord::Migration[6.1]
  def change
    create_table :roles, id: :uuid do |t|
      t.string :name, null: false
      t.belongs_to :organization, type: :uuid, null: false
      t.string :description
      t.jsonb :permissions, null: false, default: {}
      t.timestamps
    end
  end
end
