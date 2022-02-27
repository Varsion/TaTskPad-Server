module Mutations
  class UpdateAccount < Mutations::BaseMutation
    argument :name, String, required: true
    argument :avatar, ApolloUploadServer::Upload, required: false

    field :account, Types::AccountType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      account = current_account
      account.update(name: input[:name])
      if input[:avatar].present?
        account.set_avatar(input[:avatar])
      end

      if account.errors.blank?
        {account: account}
      else
        errors = Types::Base::ModelError.errors_of(account)
        {errors: errors}
      end
    end
  end
end
