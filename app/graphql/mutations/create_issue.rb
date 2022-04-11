module Mutations
  class CreateIssue < Mutations::BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :project_id, ID, required: true
    argument :priority, String, required: true
    argument :genre, String, required: true
    argument :estimate, String, required: false
    argument :customize_fields, [Types::Inputs::CustomizeFieldInput], required: false
    argument :labels, [String], required: false

    field :issue, Types::IssueType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      issue = Issue.new(input)
      issue.author = current_account
      if issue.save && issue.errors.blank?
        {
          issue: issue
        }
      else
        {
          errors: Types::Base::ModelError.errors_of(issue)
        }
      end
    end
  end
end
