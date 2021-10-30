class CreateTestData < ActiveRecord::Migration[6.1]
  def change
    create_table :test_data, id: :uuid do |t|
      t.string :name
      t.timestamps
    end
  end
end
