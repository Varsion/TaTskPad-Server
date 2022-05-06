class AddCodesInProject < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :code_url, :string, null: true
  end
end
