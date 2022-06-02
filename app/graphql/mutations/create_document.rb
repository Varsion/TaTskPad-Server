module Mutations
  class CreateDocument < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :knowledge_base_id, ID, required: false
    argument :title, String, required: true
    argument :content, String, required: true

    field :document, Types::DocumentType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!

      project = Project.find_by(id: input.delete(:project_id))

      raise GraphQL::ExecutionError, "no premiss" unless project.organization.is_member?(current_account)

      knowledge_base_id = input[:knowledge_base_id].nil? ? project.default_knowledge_base.id : input[:knowledge_base_id]

      document = Document.new(
        title: input[:title],
        content: input[:content],
        knowledge_base_id: knowledge_base_id
      )

      document.contributors << {id: current_account.id}

      if document.save && document.errors.blank?
        {
          document: document
        }
      else
        {
          errors: Types::Base::ModelError.errors_of(document)
        }
      end
    end
  end
end
