# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Update Workflow Steps Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)

    create(:membership, account: @account, organization: @organization, role: "owner")
    @project = create(:project, organization: @organization)
  end

  let(:query) do
    "
      mutation UpdateCustomizeFields($input: UpdateCustomizeFieldsInput!) {
        updateCustomizeFields(input: $input) {
          project {
            customizeFields {
              name
              type
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
            customizeFields: [
              {
                name: "Story Points",
                type: "integer"
              },
              {
                name: "Time Consumed",
                type: "string"
              }
            ]
          }
        }
      }.to_json, headers: user_headers
    result = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(result["data"]["updateCustomizeFields"]["project"]["customizeFields"].count).to eq(2)
    expect(result["data"]["updateCustomizeFields"]["project"]["customizeFields"]).to eq(
      [
        {
          name: "Story Points",
          type: "integer"
        }.as_json,
        {
          name: "Time Consumed",
          type: "string"
        }.as_json
      ]
    )
  end
end
