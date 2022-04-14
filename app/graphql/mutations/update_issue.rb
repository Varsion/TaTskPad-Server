module Mutations
  class UpdateIssue < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :assignee_id, ID, required: false
    argument :title, String, required: false
    argument :description, String, required: false
    argument :priority, String, required: false
    argument :genre, String, required: false
    argument :estimate, String, required: false
    argument :customize_fields, [Types::Inputs::CustomizeFieldInput], required: false
    argument :labels, [String], required: false

    field :issue, Types::IssueType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      customize_fields = input.delete(:customize_fields)

      issue = Issue.find_by(id: input.delete(:id))
      issue.update(input)
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
