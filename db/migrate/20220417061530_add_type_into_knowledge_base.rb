class AddTypeIntoKnowledgeBase < ActiveRecord::Migration[6.1]
  def change
    add_column :knowledge_bases, :is_default, :boolean, default: false
  end
end
