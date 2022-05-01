
module Types
  class RoleType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :permissions, [Types::PermissionType], null: false
    
    def permissions
      object.abilities
    end

    def name
      object.name.upcase_first
    end
  end
end