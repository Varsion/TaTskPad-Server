module Types
  class KnowledgeBaseType < Types::Base::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :archived, Boolean, null: false
    field :documents, [Types::DocumentType], null: true
  end
end
