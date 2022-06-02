module Mutations
  class CreateProject < Mutations::BaseMutation
    argument :organization_id, ID, required: true
    argument :name, String, required: true
    argument :code_url, String, required: false
    argument :key_word, String, required: true,
      prepare: ->(key_word, ctx) {
        key_word.upcase
      }
    argument :project_class, String, required: true

    argument :logo, ApolloUploadServer::Upload, required: false

    field :project, Types::ProjectType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      org = Organization.find_by(id: input[:organization_id])

      raise GraphQL::ExecutionError, "You are not a member of this organization" unless org.is_member?(current_account)
      project = Project.new(input)
      project.init_workflow_steps
      project.upload_logo(input[:logo])
      if project.save && project.errors.blank?
        {project: project}
      else
        errors = Types::Base::ModelError.errors_of(project)
        {errors: errors}
      end
    end
  end
end
