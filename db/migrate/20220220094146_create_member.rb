class CreateMember < ActiveRecord::Migration[6.1]
  def change
    create_table :members, id: :uuid do |t|
      t.belongs_to :account, type: :uuid, null: false, index: true
      t.belongs_to :organization, type: :uuid, null: false, index: true
      t.string :role, null: false
      t.timestamps
    end
  end
end
