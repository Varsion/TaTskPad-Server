module Mutations
  class ArchiveKnowledgeBase < Mutations::BaseMutation
    argument :id, ID, required: true

    field :knowledge_base, Types::KnowledgeBaseType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      knowledge_base = KnowledgeBase.find_by(id: input[:id])

      raise GraphQL::ExecutionError, "No permissions" unless knowledge_base.project.organization.is_member?(current_account)
      
      knowledge_base.archive!
      { knowledge_base: knowledge_base }
    end
  end
end
