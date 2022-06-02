# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - End Sprint Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
    @bucket = create(:bucket, project: @project)
    @sprint = create(:sprint, project: @project, is_current: true, bucket: @bucket)
  end

  let(:query) do
    "
      mutation EndSprint($input: EndSprintInput!) {
        endSprint(input: $input) {
          sprint {
            name
            isCurrent
          }
          errors {
            attribute
            message
          }
        }
      }
    "
  end

  it "end sprint work" do
    post "/graphql",
      params: {
        query: query,
        variables: {
          input: {
            id: @sprint.id
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        endSprint: {
          sprint: {
            isCurrent: false
          }
        }
      }
    })
  end
end
