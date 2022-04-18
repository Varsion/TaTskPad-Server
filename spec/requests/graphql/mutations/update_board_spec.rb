
require "rails_helper"

RSpec.describe "GraphQL - Update Board Mutations", type: :request do
  before :each  do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")

    @board = create(:board, project: @project)
  end

  let :query do
    "
    mutation UpdateBoard($input: UpdateBoardInput!) {
      updateBoard(input: $input) {
        board {
          id
          name
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
            id: @board.id,
            name: "New Board Name"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateBoard: {
          board: {
            name: "New Board Name"
          }
        }
      }
    })
  end
end