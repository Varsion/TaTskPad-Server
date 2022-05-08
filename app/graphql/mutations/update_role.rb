module Mutations
  class UpdateRole < Mutations::BaseMutation
    argument :id, ID, required: true

    field :role, Types::RoleType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!

      role = Role.find_by(id: input[:id])
      role.update

      if role.save && role.errors.blank?
        {
          role: role
        }
      else
        {
          errors: Types::Base::ModelError.errors_of(role)
        }
      end
    end
  end
end
