module Mutations
  class UpdateCustomizeFields < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :customize_fields, [Types::Inputs::CustomizeFieldInput], required: true

    field :project, Types::ProjectType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      project = Project.find_by(id: input[:project_id])
      project.customize_fields = input[:customize_fields].as_json

      raise GraphQL::ExecutionError, "No permissions" unless project.organization.is_owner?(current_account)

      if project.save && project.errors.blank?
        { project: project }
      else
        errors = Types::Base::ModelError.errors_of(project)
        { errors: errors }
      end
    end
  end
end