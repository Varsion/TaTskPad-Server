# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Get Organization Query", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)
    @organization = create(:organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let(:query) do
    "
      query GetOrganization($organizationId: ID!) {
        organization(organizationId: $organizationId) {
          id
          name
          email
        }
      }
    "
  end

  it "Work!" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          organizationId: @organization.id
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        organization: {
          id: @organization.id,
          name: @organization.name,
          email: @organization.email
        }
      }
    })
  end

  it "Work get empty" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          organizationId: @organization.id
        }
      }.to_json, headers: user_headers(account: @account_2)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        organization: nil
      }
    })
  end

  context "Project" do
    before :each do
      @project = create(:project, organization: @organization)
    end
    let(:query) do
      "
        query GetProjects($organizationId: ID!) {
          organization(organizationId: $organizationId) {
            projects {
              name
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
            organizationId: @organization.id
          }
        }.to_json, headers: user_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          organization: {
            projects: [{
              name: @project.name
            }]
          }
        }
      })
    end
  end
end
