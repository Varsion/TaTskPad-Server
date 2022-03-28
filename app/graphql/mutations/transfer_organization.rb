module Mutations
  class TransferOrganization < Mutations::BaseMutation
    argument :organization_id, ID, required: true
    argument :account_id, ID, required: true

    field :organization, Types::OrganizationType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      org = Organization.find_by(id: input[:organization_id])
      transfer_account = Account.find_by(id: input[:account_id])

      raise GraphQL::ExecutionError, "No permissions" unless org.is_owner?(current_account)
      org.transfer_to(transfer_account)
      org.reload
      if org.errors.blank?
        {organization: org}
      else
        errors = Types::Base::ModelError.errors_of(org)
        {errors: errors}
      end
    end
  end
end
