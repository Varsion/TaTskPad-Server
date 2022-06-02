# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Update Organization Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)

    @organization = create(:organization)

    create(:membership, account: @account, organization: @organization, role: "owner")
    create(:membership, account: @account_2, organization: @organization, role: "member")
  end

  let(:query) do
    "
      mutation UpdateOrganization($input: UpdateOrganizationInput!) {
        updateOrganization(input: $input) {
          organization {
            id
            name
            email
            logoUrl
            organizationClass
          }
          errors {
            attribute
            message
          }
        }
      }
    "
  end

  it "Organization not found!" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: Faker::Internet.uuid,
            name: "hello",
            email: "hello@exm.com",
            organizationClass: "Personal"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateOrganization: {
          errors: [{
            message: "Organization not found"
          }]
        }
      }
    })
  end

  it "No permissions" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: @organization.id,
            name: "hello",
            email: "hello@exm.com",
            organizationClass: "Personal"
          }
        }
      }.to_json, headers: user_headers(account: @account_2)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateOrganization: nil
      },
      errors: [
        {
          message: "No permissions",
          path: ["updateOrganization"]
        }
      ]
    })
  end

  it "Update organization successfully" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            organizationId: @organization.id,
            name: "hello",
            email: "hello@exm.com",
            organizationClass: "Personal"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateOrganization: {
          organization: {
            name: "hello",
            email: "hello@exm.com"
          }
        }
      }
    })
  end
end
