module Mutations
  class ArchiveOrganization < Mutations::BaseMutation
    argument :organization_id, ID, required: true

    field :organization, Types::OrganizationType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      org = Organization.find_by(id: input[:organization_id])
      raise GraphQL::ExecutionError, "No permissions" unless org.is_owner?(current_account)
      org.archive!
      {organization: org}
    end
  end
end
