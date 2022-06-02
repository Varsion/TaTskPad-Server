module Mutations
  class ArchiveProject < Mutations::BaseMutation
    argument :project_id, ID, required: true

    field :project, Types::ProjectType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      project = Project.find_by(id: input[:project_id])
      org = project.organization
      raise GraphQL::ExecutionError, "No permissions" unless org.is_owner?(current_account) || org.is_admin?(current_account)

      project.archive!
      {project: project}
    end
  end
end
