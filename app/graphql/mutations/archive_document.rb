module Mutations
  class ArchiveDocument < Mutations::BaseMutation
    argument :id, ID, required: true

    field :document, Types::DocumentType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      document = Document.find_by(id: input[:id])
      
      document.archive!
      { document: document }
    end
  end
end
