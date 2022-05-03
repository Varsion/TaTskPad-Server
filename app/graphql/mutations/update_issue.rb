module Mutations
  class UpdateIssue < Mutations::BaseMutation
    argument :id, ID, required: false
    argument :key_number, String, required: false
    argument :assignee_id, ID, required: false
    argument :title, String, required: false
    argument :status, String, required: false
    argument :description, String, required: false
    argument :priority, String, required: false
    argument :genre, String, required: false
    argument :bucket_id, ID, required: false
    argument :estimate, String, required: false
    argument :customize_fields, [Types::Inputs::CustomizeFieldInput], required: false
    argument :labels, [String], required: false

    field :issue, Types::IssueType, null: true
    field :errors, [Types::Base::ModelError], null: true

    def resolve(input)
      customize_fields = input.delete(:customize_fields)

      if input[:id].present?
        issue = Issue.find_by(id: input.delete(:id))
      elsif input[:key_number].present?
        issue = Issue.find_by(key_number: input.delete(:key_number))
      else
        issue = nil
      end

      if issue.nil?
        return {
          errors: [{
            attribute: "issue",
            message: "is no found"
          }]
        }
      end

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
