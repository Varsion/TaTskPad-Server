class CreateOrganization < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.jsonb :settings, default: { notifications: { email: false } }
      t.string :invite_code
      t.string :email
      t.string :organization_class
      t.timestamps
    end
  end
end
