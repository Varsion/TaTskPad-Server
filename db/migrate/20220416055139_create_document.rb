class CreateDocument < ActiveRecord::Migration[6.1]
  def change
    create_table :documents, id: :uuid do |t|
      t.string :title
      t.text :content
      t.belongs_to :knowledge_base, type: :uuid, foreign_key: true
      t.jsonb :contributors, default: {}
      t.jsonb :histories, default: {}
      t.timestamps
    end
  end
end
