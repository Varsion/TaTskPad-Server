# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Update Workflow Steps Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)

    create(:membership, account: @account, organization: @organization, role: "owner")
    @project = create(:project, organization: @organization)

    @current_workflow = []
    @project.workflow_steps.each do |step|
      @current_workflow << step.as_json
    end
  end

  let(:query) do
    "
      mutation UpdateWorkflowSteps($input: UpdateWorkflowStepsInput!) {
        updateWorkflowSteps(input: $input) {
          project {
            workflowSteps {
              name
              description
            }
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
          input: {
            projectId: @project.id,
            workflowSteps: @current_workflow + [
              {
                name: "hello",
                description:"hello",
              },
              {
                name: "hello2",
                description:"hello",
              }
            ]
          }
        }
      }.to_json, headers: user_headers
    result = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(result["data"]["updateWorkflowSteps"]["project"]["workflowSteps"].count).to eq(5)
    expect(result["data"]["updateWorkflowSteps"]["project"]["workflowSteps"]).to eq(
      @current_workflow + [
        {
          name: "hello",
          description:"hello",
        }.as_json,
        {
          name: "hello2",
          description:"hello",
        }.as_json
      ]
    )
  end
end