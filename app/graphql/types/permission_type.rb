# frozen_string_literal: true

module Types
  class PermissionType < Types::Base::Object
    field :scope, String, null: true

    class ControlActionsType < Types::Base::Object
      field :key, String, null: true
      field :value, Boolean, null: true
    end

    field :actions, [ControlActionsType], null: true

    def action
      object[:actions]
    end
  end
end
