# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Archive Organization Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)
    @account_3 = create(:account)

    @organization = create(:organization)

    @project = create(:project, organization: @organization)

    create(:membership, account: @account, organization: @organization, role: "owner")
    create(:membership, account: @account_2, organization: @organization, role: "admin")
    create(:membership, account: @account_3, organization: @organization, role: "member")
  end

  let(:query) do
    "
      mutation ArchiveProject($input: ArchiveProjectInput!) {
        archiveProject(input: $input) {
          project {
            id
            status
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
            projectId: @project.id
          }
        }
      }.to_json, headers: user_headers(account: @account_3)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        archiveProject: nil
      },
      errors: [
        {
          message: "No permissions",
          path: ["archiveProject"]
        }
      ]
    })
  end

  it "Archive organization successfully" do
    account = [@account, @account_2].sample
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            projectId: @project.id
          }
        }
      }.to_json, headers: user_headers(account: account)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        archiveProject: {
          project: {
            id: @project.id,
            status: "archived"
          }
        }
      }
    })
  end
end
