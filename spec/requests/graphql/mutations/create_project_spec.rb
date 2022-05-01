# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Create Project Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)
    @organization = create(:organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let(:query) do
    "
      mutation CreateProject($input: CreateProjectInput!) {
        createProject(input: $input) {
          project {
            name
            status
            logoUrl
          }
        }
      }
    "
  end

  it "Create Project Success without logo" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: @organization.id,
            name: "Test Project",
            projectClass: "software",
            keyWord: "test"
          }
        }
      }.to_json, headers: user_headers
    expect(KnowledgeBase.count).to eq(1)
    expect(Project.first.backlog).to eq(Bucket.first)
    expect(Board.count).to eq(1)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createProject: {
          project: {
            name: "Test Project",
            status: "active"
          }
        }
      }
    })
  end

  it "Create Project Success with logo" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: @organization.id,
            name: "Test Project",
            projectClass: "software",
            keyWord: "test",
            logo: Rack::Test::UploadedFile.new(file_fixture("logo.jpg"), "image/jpg")
          }
        }
      }, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createProject: {
          project: {
            name: "Test Project",
            status: "active",
            logoUrl: /logo.jpg/
          }
        }
      }
    })
  end

  it "Can't Create Project if you not this organization's member" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: @organization.id,
            name: "Test Project",
            projectClass: "software",
            keyWord: "test"
          }
        }
      }.to_json, headers: user_headers(account: @account_2)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: { createProject: nil },
      errors: [{
        message: "You are not a member of this organization",
      }]
    })
  end
end
