module Resolvers
  class OrganizationResolver < BaseResolver
    type Types::OrganizationType, null: true

    argument :organization_id, ID, required: true
    def resolve(organization_id:)
      authenticate_user!
      current_account.organizations.find_by(id: organization_id)
    end
  end
end
