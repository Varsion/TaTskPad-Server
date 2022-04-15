
require "rails_helper"

RSpec.describe "GraphQL - Create Comment Mutations", type: :request do
  before :each  do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @issue = create(:issue, project: @project, author: @account)
  end

  let :query do
    "
    mutation CreateComment($input: CreateCommentInput!) {
      createComment(input: $input) {
        comment {
          content
          account {
            id
          }
        }
      }
    }
    "
  end

  it "work!" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            issueId: @issue.id,
            content: "New Comment"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createComment: {
          comment: {
            content: "New Comment",
            account: {
              id: @account.id
            }
          }
        }
      }
    })
  end
end