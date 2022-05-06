# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Role Query", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)

    @role = create(:role, organization: @organization)
  end

  let(:query) do
    "
      query ($id: ID!) {
        role(id: $id) {
          name
          description
          permissions {
            scope
            actions {
              key
              value
            }
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
          id: @role.id
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        role: {
          description: @role.description
        }
      }
    })
  end

end
