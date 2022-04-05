module Mutations
  class UpdateProject < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :name, String, required: true
    argument :version_format, String, required: true
    argument :project_class, String, required: true
    argument :logo, ApolloUploadServer::Upload, required: false

    field :project, Types::ProjectType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      
      project = Project.find_by(id: input[:project_id])
      org = project.organization

      raise GraphQL::ExecutionError, "No permissions" unless org.is_owner?(current_account) || org.is_admin?(current_account)

      project.update(
        name: input[:name],
        version_format: input[:version_format],
        project_class: input[:project_class]
      )

      project.upload_logo(input[:logo]) if project[:logo].present?

      if project.save && project.errors.blank?
        { project: project }
      else
        errors = Types::Base::ModelError.errors_of(project)
        { errors: errors }
      end
    end
  end
end
