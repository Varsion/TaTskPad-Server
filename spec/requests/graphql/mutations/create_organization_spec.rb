# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Create Organization Mutations", type: :request do
  before :each do
    @account = create(:account)
  end

  let(:query) do
    "
      mutation CreateOrganization($input: CreateOrganizationInput!) {
        createOrganization(input: $input) {
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

  it "Works!" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            name: "Test Org",
            email: "123@exm.com",
            organizationClass: "Personal",
            logo: Rack::Test::UploadedFile.new(file_fixture("logo.jpg"), "image/jpg")
          }
        }
      }, headers: user_headers
      expect(response.status).to eq 200
      expect(Organization.first.owner.account).to eq @account
      expect(response.body).to include_json({
        data: {
          createOrganization: {
            organization: {
              organizationClass: "Personal",
              name: "Test Org",
              email: "123@exm.com"
            }
          }
        }
      })
  end
end