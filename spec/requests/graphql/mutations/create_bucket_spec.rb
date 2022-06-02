require "rails_helper"

RSpec.describe "GraphQL - Create Bucket Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let :query do
    "
    mutation CreateBucket($input: CreateBucketInput!) {
      createBucket(input: $input) {
        bucket {
          id
          name
          isRelease
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
            name: "New Bucket",
            projectId: @project.id,
            isRelease: false
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createBucket: {
          bucket: {
            name: "New Bucket",
            isRelease: false
          }
        }
      }
    })
  end
end
