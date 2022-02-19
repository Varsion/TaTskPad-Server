# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Sign Up Mutations", type: :request do

  let(:query) do
    "
      mutation signUp($input: SignUpInput!) {
        signUp(input: $input) {
          account {
            id
            email
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
            email: "123@exmaple.com",
            password: "123456",
            name: "123"
          }
        }
      }.to_json, headers: basic_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          signUp:{
            account: {
              email: "123@exmaple.com"
            }
          }
        }
      })
  end

  it "Fails! Same Email" do
    account = create :account
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            email: account.email,
            password: "123456",
            name: "123"
          }
        }
      }.to_json, headers: basic_headers
    expect(response.status).to eq 200
    expect(Account.count).to eq 1
    expect(response.body).to include_json({
      data: {
        signUp:{
          errors: [
            {
              attribute: "email",
              message: "has already been taken"
            }
          ]
        }
      }
    })
  end
end