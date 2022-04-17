module Types
  class DocumentType < Types::Base::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: false
    field :knowledge_base, Types::KnowledgeBaseType, null: false
    field :contributors, [Types::AccountType], null: false

    def contributors
      object.contributors.map { |contributor| Account.find(contributor.id) }
    end
  end
end
