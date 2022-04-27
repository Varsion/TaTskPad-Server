
require "rails_helper"

RSpec.describe "GraphQL - Update Issue Mutations", type: :request do
  before :each  do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")

    @assignee = create(:account)

    @issue = create(:issue, project: @project, author: @account)
    @bucket = create(:bucket, project: @project)
  end

  let(:query) do
    "
    mutation UpdateIssue($input: UpdateIssueInput!) {
      updateIssue(input: $input) {
        issue {
          id
          title
          description
          priority
          genre
          estimate
          project {
            id
          }
          assignee {
            id
          }
          customizeFields {
            name
            value
          }
        }
      }
    }
    "
  end

  it "work! just update title" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            id: @issue.id,
            title: "New Issue Title"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateIssue: {
          issue: {
            title: "New Issue Title",
            genre: @issue.genre
          }
        }
      }
    })
  end

  it "work! just assignee" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            id: @issue.id,
            assigneeId: @assignee.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateIssue: {
          issue: {
            assignee: {
              id: @assignee.id
            }
          }
        }
      }
    })
  end

  it "just move bucket" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            id: @issue.id,
            bucketId: @bucket.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateIssue: {
          issue: {
            id: @issue.id
          }
        }
      }
    })
  end
end
