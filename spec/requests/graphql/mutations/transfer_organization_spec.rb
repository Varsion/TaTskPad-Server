# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Transfer Organization Mutations", type: :request do
  before :each do
    @account = create(:account)
    @account_2 = create(:account)
    @account_3 = create(:account)

    @organization = create(:organization)

    create(:membership, account: @account, organization: @organization, role: "owner")
    create(:membership, account: @account_2, organization: @organization, role: "member")
  end

  let(:query) do
    "
      mutation TransferOrganization($input: TransferOrganizationInput!) {
        transferOrganization(input: $input) {
          organization {
            id
            owner {
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

  it "No permissions" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            organizationId: @organization.id,
            accountId: @account_2.id
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
          path:["transferOrganization"]
        }
      ]
    })
  end

  it "You can't transfer to yourself" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            organizationId: @organization.id,
            accountId: @account.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        transferOrganization: {
          organization: nil,
          errors: [
            {
              message: "You can't transfer organization to yourself"
            }
          ]
        }
      }
    })
  end

  it "You can't transfer to him if he is not a member of the organization" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            organizationId: @organization.id,
            accountId: @account_3.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        transferOrganization: {
          organization: nil,
          errors: [
            {
              message: "You can't transfer organization to him if he is not a member of the organization"
            }
          ]
        }
      }
    })
  end

  it "Transfer organization successfully" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            organizationId: @organization.id,
            accountId: @account_2.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        transferOrganization: {
          organization: {
            id: @organization.id,
            owner: {
              id: @account_2.id,
              name: @account_2.name
            }
          }
        }
      }
    })
  end
end