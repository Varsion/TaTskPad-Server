
require "rails_helper"

RSpec.describe "GraphQL - Create Document Mutations", type: :request do
  before :each  do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @knowledge_base = create(:knowledge_base, project: @project)
  end

  let :query do
    "
    mutation CreateDocument($input: CreateDocumentInput!) {
      createDocument(input: $input) {
        document {
          title
          content
          contributors {
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
            projectId: @project.id,
            title: "New Document",
            content: "New Document Content",
            knowledgeBaseId: @knowledge_base.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createDocument: {
          document: {
            title: "New Document",
            content: "New Document Content",
          }
        }
      }
    })
  end

  it "work! with default knowledge base" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            projectId: @project.id,
            title: "New Document",
            content: "New Document Content"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createDocument: {
          document: {
            title: "New Document",
            content: "New Document Content",
          }
        }
      }
    })
  end
end