module Mutations
  class UpdateComment < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!

      comment = Comment.find_by(id: input[:id])

      raise GraphQL::ExecutionError, "no permission" unless comment.account_id == current_account.id

      comment.update(content: input[:content])

      if comment.save && comment.errors.blank?
        {
          comment: comment
        }
      else
        {
          errors: Types::Base::ModelError.errors_of(comment)
        }
      end
    end
  end
end
