# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Create Sprint Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)
    @organization = create(:organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @project = create(:project, organization: @organization)
    @bucket = create(:bucket, project: @project)
  end

  let(:query) do
    "
      mutation CreateSprint($input: CreateSprintInput!) {
        createSprint(input: $input) {
          sprint{
            id
            name
            version
            issueList {
              id
              name
            }
          }
          errors {
            attribute
            message
          }
        }
      }
    "
  end

  it "work" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            projectId: @project.id,
            name: "Test Sprint",
            version: "1.0",
            bucketId: @bucket.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createSprint: {
          sprint: {
            name: "Test Sprint",
            issueList: {
              id: @bucket.id
            }
          }
        }
      }
    })
  end
end
