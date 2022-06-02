# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Verify Account Mutations", type: :request do
  before :each do
    @account = create(:account)
  end

  let(:query) do
    "
      mutation verifyAccount($input: VerifyAccountInput!) {
        verifyAccount(input: $input) {
          account {
            id
            email
            verified
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
            verifyCode: @account.verify_code
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        verifyAccount: {
          account: {
            id: @account.id,
            email: @account.email,
            verified: true
          }
        }
      }
    })
  end

  it "Works! with invalid code" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            verifyCode: "123123"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        verifyAccount: {
          errors: [
            {
              attribute: "verify_code",
              message: "This Verify Code is invalid!"
            }
          ]
        }
      }
    })
  end
end
