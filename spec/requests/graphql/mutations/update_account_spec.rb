# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Update Account Mutations", type: :request do
  before :each do
    @account = create(:account)
  end

  let(:query) do
    "
      mutation updateAccount($input: UpdateAccountInput!) {
        updateAccount(input: $input) {
          account {
            id
            name
            avatar
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
            name: "new_name",
            avatar: Rack::Test::UploadedFile.new(file_fixture("logo.jpg"), "image/jpg")
          }
        }
      }, headers: user_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          updateAccount: {
            account: {
              id: @account.id,
              email: @account.email,
              name: "new_name"
            }
          }
        }
      })
  end

  it "Works! no upload avatar" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            name: "new_name"
          }
        }
      }.to_json, headers: user_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          updateAccount: {
            account: {
              id: @account.id,
              email: @account.email,
              name: "new_name",
              avatar: "https://ui-avatars.com/api/?name=new_name"
            }
          }
        }
      })
  end
end