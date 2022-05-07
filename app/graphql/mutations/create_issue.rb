module Mutations
  class CreateIssue < Mutations::BaseMutation
    argument :title, String, required: true
    argument :bucket_id, ID, required: false
    argument :description, String, required: false
    argument :project_id, ID, required: true
    argument :priority, String, required: true
    argument :genre, String, required: true
    argument :assignee_id, ID, required: false
    argument :estimate, String, required: false
    argument :customize_fields, [Types::Inputs::CustomizeFieldInput], required: false
    argument :labels, [String], required: false

    field :issue, Types::IssueType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      customize_fields = input.delete(:customize_fields)
      issue = Issue.new(input)
      issue.key_number = issue.generate_key_number
      issue.author = current_account

      issue.customize_fields = customize_fields.to_json unless customize_fields.nil?

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
