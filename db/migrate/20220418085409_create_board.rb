class CreateBoard < ActiveRecord::Migration[6.1]
  def change
    create_table :boards, id: :uuid do |t|
      t.string :name, null: false
      t.belongs_to :project, type: :uuid, null: false
      t.boolean :is_default, default: false
      t.jsonb :columns, null: false, default: {}
      t.timestamps
    end
  end
end
