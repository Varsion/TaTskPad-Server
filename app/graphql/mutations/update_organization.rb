module Mutations
  class UpdateOrganization < Mutations::BaseMutation
    argument :organization_id, ID, required: true
    argument :name, String, required: true
    argument :email, Types::Base::Email, required: true
    argument :organization_class, String, required: true
    argument :logo, ApolloUploadServer::Upload, required: false

    field :organization, Types::OrganizationType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      org = Organization.find_by(id: input[:organization_id])
      return { errors: [{ message: "Organization not found" }] } unless org

      return { errors: [{ message: "No permissions" }] } unless org.is_owner?(current_account)

      org.update(
        name: input[:name], 
        email: input[:email], 
        organization_class: input[:organization_class]
      )
      org.upload_logo(input[:logo]) if input[:logo].present?
      if org.save && org.errors.blank?
        { organization: org }
      else
        errors = Types::Base::ModelError.errors_of(org)
        { errors: errors }
      end
    end
  end
end
