module Resolvers
  class IssueResolver < BaseResolver
    type Types::IssueType, null: true

    argument :issue_id, ID, required: true
    def resolve(issue_id:)
      authenticate_user!
      Issue.find_by(id: issue_id)
    end
  end
end
