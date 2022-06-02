# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Update Project Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)

    @organization = create(:organization)

    @project = create(:project, organization: @organization)

    create(:membership, account: @account, organization: @organization, role: "owner")
    create(:membership, account: @account_2, organization: @organization, role: "member")
  end

  let(:query) do
    "
      mutation UpdateProject($input: UpdateProjectInput!) {
        updateProject(input: $input) {
          project {
            id
            name
          }
          errors {
            attribute
            message
          }
        }
      }
    "
  end

  it "No permissions" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            projectId: @project.id,
            name: "hello-project",
            versionFormat: "semver",
            projectClass: "software"
          }
        }
      }.to_json, headers: user_headers(account: @account_2)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateProject: nil
      },
      errors: [
        {
          message: "No permissions",
          path: ["updateProject"]
        }
      ]
    })
  end

  it "Update project successfully" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            projectId: @project.id,
            name: "hello-project",
            versionFormat: "semver",
            projectClass: "software"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateProject: {
          project: {
            id: @project.id,
            name: "hello-project"
          }
        }
      }
    })
  end
end
