module Types
  class CommentType < Types::Base::Object
    field :id, ID, null: false
    field :account, Types::AccountType, null: false
    field :content, String, null: false
  end
end