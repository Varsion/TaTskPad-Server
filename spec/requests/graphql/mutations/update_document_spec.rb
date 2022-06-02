require "rails_helper"

RSpec.describe "GraphQL - Update Document Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @knowledge_base = create(:knowledge_base, project: @project)
    @document = create(:document, knowledge_base: @knowledge_base)
    @knowledge_base_new = create(:knowledge_base, project: @project)
  end

  let(:query) do
    "
    mutation UpdateDocument($input: UpdateDocumentInput!) {
      updateDocument(input: $input) {
        document {
          title
          content
          knowledgeBase {
            id
          }
          contributors {
            id
            name
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
            id: @document.id,
            title: "New Issue Title"
          }
        }
      }.to_json, headers: user_headers
    result = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(result["data"]["updateDocument"]["document"]["contributors"].length).to eq 2
    expect(response.body).to include_json({
      data: {
        updateDocument: {
          document: {
            title: "New Issue Title"
          }
        }
      }
    })
  end

  it "work! move to another knowledge base" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            id: @document.id,
            knowledgeBaseId: @knowledge_base_new.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateDocument: {
          document: {
            knowledgeBase: {
              id: @knowledge_base_new.id
            }
          }
        }
      }
    })
  end
end
