module Types
  class AccountType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: false
    field :token, String, null: true
    field :verified, Boolean, null: false
  end
end