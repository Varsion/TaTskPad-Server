module Mutations
  class SignIn < Mutations::BaseMutation
    argument :email, Types::Base::Email, required: true
    argument :password, String, required: true

    field :account, Types::AccountType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      account = Account.find_by(email: input[:email])
      if account && account.authenticate(input[:password])
        token = account.login
        return {
          account: {
            id: account.id,
            email: account.email,
            token: token
          }
        }
      end

      return {
          errors: [{
          attribute: "account",
          message: "Please check email and password"
        }]
      }
    end
  end
end
