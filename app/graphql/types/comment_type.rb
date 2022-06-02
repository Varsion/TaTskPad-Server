module Types
  class CommentType < Types::Base::Object
    field :id, ID, null: false
    field :account, Types::AccountType, null: false
    field :content, String, null: false
    field :created_at, String, null: false

    def created_at
      object.created_at.to_formatted_s(:long)
    end
  end
end
