# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Create Role Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let(:query) do
    "
      mutation CreateRole($input: CreateRoleInput!) {
        createRole(input: $input) {
          role {
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

  it "work" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: @organization.id,
            name: "admin",
            description: "Admin role"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq(200)
    expect(response.body).to include_json({
      data: {
        createRole: {
          role: {
            name: "Admin"
          }
        }
      }
    })
  end

  it "name is uniqueness for a organization" do
    role = create(:role, organization: @organization, name: "admin")
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: @organization.id,
            name: "admin",
            description: "Admin role"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq(200)
    expect(response.body).to include_json({
      data: {
        createRole: {
          role: nil,
          errors: [{
            attribute: "name",
            message: "has already been taken"
          }]
        }
      }
    })
  end
end
