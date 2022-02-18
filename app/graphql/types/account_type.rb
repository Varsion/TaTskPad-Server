module Types
  class AccountType < Types::Base::Object
    field :id, ID, null: false
    field :email, String, null: false
    field :token, String, null: true
  end
end