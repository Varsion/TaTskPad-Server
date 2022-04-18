module Mutations
  class UpdateBoard < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true

    field :board, Types::BoardType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      board = Board.find_by(id: input.delete(:id))

      board.update(input)

      {board: board}
    end
  end
end
