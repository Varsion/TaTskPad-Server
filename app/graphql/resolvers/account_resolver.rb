module Resolvers
  class AccountResolver < BaseResolver
    type Types::AccountType, null: true

    def resolve
      authenticate_user!
      current_account
    end
  end
end
