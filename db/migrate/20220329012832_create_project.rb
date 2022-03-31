class CreateProject < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.string :key_word
      t.string :project_class
      t.string :status, default: "active"
      t.string :version_format
      t.jsonb :workflow_steps, default: {}
      t.jsonb :customize_fields, default: {}
      t.belongs_to :organization, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
