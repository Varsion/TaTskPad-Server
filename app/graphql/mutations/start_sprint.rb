module Mutations
  class StartSprint < Mutations::BaseMutation
    argument :id, ID, required: true

    field :sprint, Types::SprintType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      sprint = Sprint.find_by(id: input[:id])
      project = sprint.project
      if project.current_sprint.present? && project.current_sprint != sprint
        return {
          errors: [{
            attribute: "sprint",
            message: "Current Sprint is not over yet"
          }]
        }
      end

      if sprint.update(is_current: true)
        {sprint: sprint}
      else
        errors = Types::Base::ModelError.errors_of(org)
        {errors: errors}
      end
    end
  end
end
