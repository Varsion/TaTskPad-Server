module Mutations
  class UpdateKnowledgeBase < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :title, String, required: true
    argument :description, String, required: false

    field :knowledge_base, Types::KnowledgeBaseType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      knowledge_base = KnowledgeBase.find_by(id: input.delete(:id))

      raise GraphQL::ExecutionError, "no premiss" unless knowledge_base.project.organization.is_member?(current_account)

      knowledge_base.update(input.to_h)

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
