class CreateKnowledgeBase < ActiveRecord::Migration[6.1]
  def change
    create_table :knowledge_bases, id: :uuid do |t|
      t.string :title
      t.text :description
      t.belongs_to :project, type: :uuid, foreign_key: true
      t.boolean :archived, default: false
      t.timestamps
    end
  end
end
