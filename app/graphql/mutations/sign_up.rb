module Mutations
  class SignUp < Mutations::BaseMutation

    argument :email, Types::Base::Email, required: true
    argument :password, String, required: true
    argument :name, String, required: true

    field :account, Types::AccountType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      account = Account.new(input)
      if account.save && account.errors.blank?
        # send verify email
        {
          account: account
        }
      else
        errors = Types::Base::ModelError.errors_of(account)
        {errors: errors}
      end
    end
  end
end