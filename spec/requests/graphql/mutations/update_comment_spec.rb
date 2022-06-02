require "rails_helper"

RSpec.describe "GraphQL - Update Comment Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @issue = create(:issue, project: @project, author: @account)
    @comment = create(:comment, issue: @issue, account: @account)
  end

  let :query do
    "
    mutation UpdateComment($input: UpdateCommentInput!) {
      updateComment(input: $input) {
        comment {
          content
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
            id: @comment.id,
            content: "new content"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateComment: {
          comment: {
            content: "new content"
          }
        }
      }
    })
  end

  it "you can't update other's comment" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            id: @comment.id,
            content: "new content"
          }
        }
      }.to_json, headers: user_headers(account: @account_2)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateComment: nil
      },
      errors: [{
        message: "no permission"
      }]
    })
  end
end
