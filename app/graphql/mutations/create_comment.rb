module Mutations
  class CreateComment < Mutations::BaseMutation
    argument :issue_id, ID, required: true
    argument :content, String, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      authenticate_user!
      comment = Comment.new(
        content: input[:content],
        issue_id: input[:issue_id],
        account_id: current_account.id
      )
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
