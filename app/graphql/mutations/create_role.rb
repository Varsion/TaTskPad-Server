module Mutations
  class CreateRole < Mutations::BaseMutation
    argument :organization_id, ID, required: true
    argument :name, String, required: true, 
      prepare: ->(key_word, ctx) {
        key_word.downcase
      }
    argument :description, String, required: false

    field :role, Types::RoleType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      org = Organization.find_by(id: input[:organization_id])

      role = Role.new(input)

      if role.save && role.errors.blank?
        {role: role}
      else
        {errors: Types::Base::ModelError.errors_of(role)}
      end
    end
  end
end
