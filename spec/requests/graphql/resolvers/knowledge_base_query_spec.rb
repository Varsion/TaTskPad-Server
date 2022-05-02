require "rails_helper"

RSpec.describe "GraphQL - Knowledge Base Query", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @knowledge_base = create(:knowledge_base, project: @project)
  end

  let(:query) do
    "
      query ($id: ID!) {
        knowledgeBase(id: $id) {
          id
          title
        }
      }
    "
  end

  it "work" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          id: @knowledge_base.id
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        knowledgeBase: {
          id: @knowledge_base.id,
          title: @knowledge_base.title
        }
      }
    })
  end
end
