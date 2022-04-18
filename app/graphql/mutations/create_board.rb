module Mutations
  class CreateBoard < Mutations::BaseMutation
    argument :project_id, ID, required: true
    argument :name, String, required: true

    field :board, Types::BoardType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      project = Project.find_by(id: input[:project_id])

      raise GraphQL::ExecutionError, "no premiss" unless project.organization.is_member?(current_account)

      board = Board.new(
        name: input[:name],
        project: project
      )
      if board.save && board.errors.blank?
        {board: board}
      else
        {errors: Types::Base::ModelError.errors_of(board)}
      end
    end
  end
end
