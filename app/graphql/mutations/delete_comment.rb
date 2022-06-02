module Mutations
  class DeleteComment < Mutations::BaseMutation
    argument :id, ID, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!

      comment = Comment.find_by(id: input[:id])

      raise GraphQL::ExecutionError, "no permission" unless comment.account_id == current_account.id

      comment.delete

      {comment: comment}
    end
  end
end
