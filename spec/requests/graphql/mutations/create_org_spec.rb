# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Create Organization Mutations", type: :request do
  before :each do
    @account = create(:account)
  end

  let(:query) do
    "
      mutation CreateOrg($input: CreateOrgInput!) {
        createOrg(input: $input) {
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
      expect(response.body).to include_json({
        data: {
          createOrg: {
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