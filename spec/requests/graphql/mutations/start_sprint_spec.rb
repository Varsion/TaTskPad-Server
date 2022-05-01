# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Start Sprint Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @sprint = create(:sprint, project: @project)
  end

  let(:query) do
    "
      mutation StartSprint($input: StartSprintInput!) {
        startSprint(input: $input) {
          sprint {
            name
            isCurrent
          }
          errors {
            attribute
            message
          }
        }
      }
    "
  end

  it "start sprint work" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            id: @sprint.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        startSprint: {
          sprint: {
            isCurrent: true
          }
        }
      }
    })
  end

  it "has a progressing sprint" do
    sprint = create(:sprint, project: @project, is_current: true)
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            id: @sprint.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        startSprint: {
          errors: [{
            attribute: "sprint",
            message: "Current Sprint is not over yet"
          }]
        }
      }
    })
  end
end