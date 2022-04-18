
require "rails_helper"

RSpec.describe "GraphQL - Create Board Mutations", type: :request do
  before :each  do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let :query do
    "
    mutation CreateBoard($input: CreateBoardInput!) {
      createBoard(input: $input) {
        board {
          id
          name
          columns {
            name
          }
        }
      }
    }
    "
  end

  it "work!" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            projectId: @project.id,
            name: "New Board"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createBoard: {
          board: {
            name: "New Board",
            columns: [{
              name: "Todo"
            }]
          }
        }
      }
    })
  end
end