require "rails_helper"

RSpec.describe "GraphQL - Test Resolver", type: :request do
  before :each do
    @data = TestData.create(name: "TestName")
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
      expect(response.status).to eq(200)
      expect(response.body).to include_json(
        data:{
          hello: {
            id: @data.id,
            name: @data.name
          }
        }
      )
  end
end