module Mutations
  class VerifyAccount < Mutations::BaseMutation
    argument :verify_code, String, required: true


    field :account, Types::AccountType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      account = current_account.verify_account(input[:verify_code])
      if current_account.errors.blank?
        {
          account: current_account
        }
      else
        errors = Types::Base::ModelError.errors_of(current_account)
        {errors: errors}
      end
    end
  end
end
