class CreateSprint < ActiveRecord::Migration[6.1]
  def change
    create_table :sprints, id: :uuid do |t|
      t.belongs_to :project, type: :uuid
      t.string :name, null: false
      t.string :version, null: false
      t.boolean :is_current, default: false
      t.timestamps
    end
  end
end
