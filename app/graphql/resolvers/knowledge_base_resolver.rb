module Resolvers
  class KnowledgeBaseResolver < BaseResolver
    type Types::KnowledgeBaseType, null: false

    argument :id, ID, required: true
    def resolve(id:)
      authenticate_user!
      knowledge_base = KnowledgeBase.find_by(id: id)
      return nil if knowledge_base.nil?
      knowledge_base.project.organization.is_member?(current_account) ? knowledge_base : nil
    end
  end
end
