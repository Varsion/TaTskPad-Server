require "rails_helper"

RSpec.describe "GraphQL - Update Knowledge Base Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @knowledge_base = create(:knowledge_base, project: @project)
  end

  let :query do
    "
    mutation UpdateKnowledgeBase($input: UpdateKnowledgeBaseInput!) {
      updateKnowledgeBase(input: $input) {
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
            id: @knowledge_base.id,
            title: "New Knowledge Base"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateKnowledgeBase: {
          knowledgeBase: {
            title: "New Knowledge Base"
          }
        }
      }
    })
  end
end
