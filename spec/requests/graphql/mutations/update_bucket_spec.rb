require "rails_helper"

RSpec.describe "GraphQL - Update Bucket Mutations", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")

    @bucket = create(:bucket, project: @project)
  end

  let :query do
    "
    mutation UpdateBucket($input: UpdateBucketInput!) {
      updateBucket(input: $input) {
        bucket {
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
            id: @bucket.id,
            name: "New Bucket"
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        updateBucket: {
          bucket: {
            name: "New Bucket"
          }
        }
      }
    })
  end
end
