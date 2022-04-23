# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Sign In Mutations", type: :request do
  before :each do
    @account = create(:account)
  end

  let(:query) do
    "
      mutation signIn($input: SignInInput!) {
        signIn(input: $input) {
          account {
            id
            email
            token
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
            email: @account.email,
            password: @account.password
          }
        }
      }.to_json, headers: basic_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          signIn:{
            account: {
              email: @account.email,
              token: /\w+/
            }
          }
        }
      })
  end

  it "password fails" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            email: @account.email,
            password: "10010"
          }
        }
      }.to_json, headers: basic_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          signIn:{
            account: nil,
            errors: [{
              attribute: "account",
              message: "Please check email and password"
            }]
          }
        }
      })
  end
end