class CreateIssue < ActiveRecord::Migration[6.1]
  def change
    create_table :issues, id: :uuid do |t|
      t.string :title, null: false
      t.text :description
      t.belongs_to :project, type: :uuid, null: false, foreign_key: true
      t.belongs_to :author, type: :uuid, null: false, foreign_key: {to_table: :accounts}
      t.belongs_to :assignee, type: :uuid, foreign_key: {to_table: :accounts}
      t.string :status, null: false, default: "backlog"
      t.string :priority, null: false, default: "p2"
      t.string :genre, null: false, default: "story"
      t.string :estimate, default: "0d"
      t.jsonb :customize_fields, default: {}
      t.jsonb :histories, default: {}
      t.jsonb :labels, default: {}
      t.timestamps
    end
  end
end
