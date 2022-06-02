require "rails_helper"

RSpec.describe "GraphQL - Create Knowledge Base Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let :query do
    "
    mutation CreateKnowledgeBase($input: CreateKnowledgeBaseInput!) {
      createKnowledgeBase(input: $input) {
        knowledgeBase {
          id
          title
          description
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
            title: "New Knowledge Base",
            projectId: @project.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createKnowledgeBase: {
          knowledgeBase: {
            title: "New Knowledge Base"
          }
        }
      }
    })
  end
end
