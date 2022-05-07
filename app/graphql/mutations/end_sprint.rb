module Mutations
  class EndSprint < Mutations::BaseMutation
    argument :id, ID, required: true

    field :sprint, Types::SprintType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      sprint = Sprint.find_by(id: input[:id])

      if sprint.update(is_current: false)
        {sprint: sprint}
      else
        errors = Types::Base::ModelError.errors_of(sprint)
        {errors: errors}
      end
    end
  end
end
