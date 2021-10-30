require "rails_helper"

RSpec.describe "GraphQL - Test Resolver", type: :request do
  before :each do
    TestData.create(name: "TestName")
  end
  let(:query) do
    "
      query {
        hello {
          id
          name
        }
      }
    "
  end

  it "works" do
    post "/graphql",
      params: {query: query, variables: {}}.to_json,
      headers: { "Content-Type" => "application/json" }
      byebug
  end
end