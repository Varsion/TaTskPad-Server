# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Account Query", type: :request do
  before :each do
    @account = create(:account)
  end

  let(:query) do
    "
      query account {
        account {
          id
          name
          avatar
          email
        }
      }
    "
  end

  it "Works!" do
    post "/graphql",
      params: {
        query: query, 
        variables: {}
      }.to_json, headers: user_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          account: {
            id: @account.id,
            name: @account.name,
            email: @account.email
          }
        }
      })
  end

  context "organization" do
    let(:query) do
      "      
      query account {
        account {
          id
          name
          organizations {
            id
            name
          }
        }
      }
      "
    end

    it "works!" do
      @organization = create(:organization)
      create(:membership, account: @account, organization: @organization, role: "owner")
      post "/graphql",
        params: {
          query: query, 
          variables: {}
        }.to_json, headers: user_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          account: {
            id: @account.id,
            name: @account.name,
            organizations: [{
              id: @organization.id
            }]
          }
        }
      })
    end
  end
  
end