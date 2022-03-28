# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Archive Organization Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)

    @organization = create(:organization)

    create(:membership, account: @account, organization: @organization, role: "owner")
    create(:membership, account: @account_2, organization: @organization, role: "member")
  end

  let(:query) do
    "
      mutation ArchiveOrganization($input: ArchiveOrganizationInput!) {
        archiveOrganization(input: $input) {
          organization {
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
          organizationId: @organization.id
        }
      }
    }.to_json, headers: user_headers(account: @account_2)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        archiveOrganization: nil
      },
      errors: [
        {
          message: "No permissions", 
          path:["archiveOrganization"]
        }
      ]
    })
  end

  it "Archive organization successfully" do
    post "/graphql",
    params: {
      query: query, 
      variables: {
        input: {
          organizationId: @organization.id
        }
      }
    }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        archiveOrganization: {
          organization: {
            status: "archived"
          }
        }
      }
    })
  end
end