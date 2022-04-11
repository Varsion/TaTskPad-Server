
require "rails_helper"

RSpec.describe "GraphQL - Create Issue Mutations", type: :request do
  before :each  do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let(:query) do
    "
    mutation CreateIssue($input: CreateIssueInput!) {
      createIssue(input: $input) {
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
          author {
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

  it "work!" do
    post "/graphql",
    params: {
      query: query, 
      variables: {
        input: {
          title: "word!",
          description: "word!",
          projectId: @project.id,
          priority: "p2",
          genre: "bug"
        }
      }
    }.to_json, headers: user_headers
  expect(response.status).to eq 200
  expect(response.body).to include_json({
    data: {
      createIssue: {
        issue: {
          title: "word!",
          description: "word!",
          project: {
            id: @project.id
          },
          author: {
            id: @account.id
          },
          genre: "bug"
        }
      }
    }
  })
  end
end
