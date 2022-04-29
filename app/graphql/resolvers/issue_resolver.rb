module Resolvers
  class IssueResolver < BaseResolver
    type Types::IssueType, null: true

    argument :issue_id, ID, required: false
    argument :key_number, String, required: false
    def resolve(input)
      authenticate_user!
      if input[:issue_id].present?
        issue = Issue.find_by(id: input[:issue_id])
      elsif input[:key_number].present?
        issue = Issue.find_by(key_number: input[:key_number])
      else
        issue = nil
      end
      issue
    end
  end
end
