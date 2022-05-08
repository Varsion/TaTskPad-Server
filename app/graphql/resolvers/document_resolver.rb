module Resolvers
  class DocumentResolver < BaseResolver
    type Types::DocumentType, null: true

    argument :id, ID, required: true
    def resolve(id:)
      authenticate_user!
      Document.find_by(id: id)
    end
  end
end
