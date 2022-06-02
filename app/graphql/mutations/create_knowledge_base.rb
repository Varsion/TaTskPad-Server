module Mutations
  class CreateKnowledgeBase < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: false

    field :knowledge_base, Types::KnowledgeBaseType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!

      project = Project.find_by(id: input[:project_id])

      raise GraphQL::ExecutionError, "no premiss" unless project.organization.is_member?(current_account)

      knowledge_base = KnowledgeBase.new(input)

      if knowledge_base.save && knowledge_base.errors.blank?
        {
          knowledge_base: knowledge_base
        }
      else
        {
          errors: Types::Base::ModelError.errors_of(knowledge_base)
        }
      end
    end
  end
end
