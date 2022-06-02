# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Archive Knowledge Base Mutations", type: :request do
  before :each do
    @account = create(:account)

    @organization = create(:organization)

    create(:membership, account: @account, organization: @organization, role: "member")

    @project = create(:project, organization: @organization)
    @knowledge_base = create(:knowledge_base, project: @project)
  end

  let(:query) do
    "
      mutation ArchiveKnowledgeBase($input: ArchiveKnowledgeBaseInput!) {
        archiveKnowledgeBase(input: $input) {
          knowledgeBase {
            archived
          }
        }
      }
    "
  end

  it "Archive KnowledgeBase successfully" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            id: @knowledge_base.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        archiveKnowledgeBase: {
          knowledgeBase: {
            archived: true
          }
        }
      }
    })
  end
end
