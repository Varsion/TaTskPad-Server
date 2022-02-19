module Mutations
  class SignIn < Mutations::BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :account, Types::AccountType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      account = Account.find_by(email: input[:email])
      if account && account.authenticate(input[:password])
        token = account.login
        {
          account: {
            id: account.id,
            email: account.email,
            token: token
          }
        }
      else
        errors = Types::Base::ModelError.errors_of(account)
        {errors: errors}
      end
    end
  end
end
