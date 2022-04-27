module Mutations
  class CreateSprint < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :name, String, required: true
    argument :version, String, required: true


    field :sprint, Types::SprintType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!

      project = Project.find_by(id: input[:project_id])

      sprint = Sprint.new(input)

      if sprint.save && sprint.errors.blank?
        { sprint: sprint }
      else
        errors = Types::Base::ModelError.errors_of(sprint)
        { errors: errors }
      end
    end
  end
end
