module Mutations
  class CreateOrg < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, Types::Base::Email, required: true
    argument :organization_class, String, required: true
    argument :logo, ApolloUploadServer::Upload, required: true

    field :organization, Types::OrganizationType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      org = Organization.create(
        name: input[:name],
        email: input[:email],
        organization_class: input[:organization_class]
      )
      org.upload_logo(input[:logo])
      org.set_owner(current_account)
      if org.save && org.errors.blank?
        { organization: org }
      else
        errors = Types::Base::ModelError.errors_of(org)
        { errors: errors }
      end
    end
  end
end
