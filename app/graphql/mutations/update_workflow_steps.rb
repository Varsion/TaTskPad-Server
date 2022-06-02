module Mutations
  class UpdateWorkflowSteps < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :workflow_steps, [Types::Inputs::WorkflowStepInput], required: true

    field :project, Types::ProjectType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      project = Project.find_by(id: input[:project_id])
      project.workflow_steps = input[:workflow_steps].as_json

      raise GraphQL::ExecutionError, "No permissions" unless project.organization.is_owner?(current_account)

      if project.save && project.errors.blank?
        {project: project}
      else
        errors = Types::Base::ModelError.errors_of(project)
        {errors: errors}
      end
    end
  end
end
