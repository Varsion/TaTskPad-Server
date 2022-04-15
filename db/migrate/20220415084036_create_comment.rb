class CreateComment < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.belongs_to :issue, type: :uuid, foreign_key: true
      t.belongs_to :account, type: :uuid, foreign_key: true
      t.text :content
      t.timestamps
    end
  end
end
