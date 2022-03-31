# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Account Query", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let(:query) do
    "
      query Project($projectId: ID!) {
        project(projectId: $projectId) {
          id
          name
          workflowSteps {
            name
            description
          }
          organization {
            id
          }
        }
      }
    "
  end

  it "Work!" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          projectId: @project.id
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        project: {
          id: @project.id,
          name: @project.name,
          workflowSteps: @project.workflow_steps.as_json,
          organization: {
            id: @organization.id
          }
        }
      }
    })
  end


  it "get empty!" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          projectId: @project.id
        }
      }.to_json, headers: user_headers(account: @account_2)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        project: nil
      }
    })
  end
end