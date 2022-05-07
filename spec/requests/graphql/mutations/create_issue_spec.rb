
require "rails_helper"

RSpec.describe "GraphQL - Create Issue Mutations", type: :request do
  before :each  do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")
  end

  let(:query) do
    "
    mutation CreateIssue($input: CreateIssueInput!) {
      createIssue(input: $input) {
        issue {
          id
          title
          description
          priority
          genre
          estimate
          project {
            id
          }
          author {
            id
          }
          customizeFields {
            name
            value
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
            title: "word!",
            description: "word!",
            projectId: @project.id,
            priority: "p2",
            genre: "bug"
          }
        }
      }.to_json, headers: user_headers
    expect(Issue.first.bucket).to eq(@project.backlog)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createIssue: {
          issue: {
            title: "word!",
            description: "word!",
            project: {
              id: @project.id
            },
            author: {
              id: @account.id
            },
            genre: "bug"
          }
        }
      }
    })
  end

  it "work with customize fields" do
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            title: "word!",
            description: "word!",
            projectId: @project.id,
            priority: "p2",
            genre: "bug",
            customizeFields: [
              {
                name: "test",
                type: "string",
                value: "value"
              }
            ]
          }
        }
      }.to_json, headers: user_headers
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createIssue: {
          issue: {
            customizeFields: [{
              name: "test",
              value: "value"
            }]
          }
        }
      }
    })
  end

  it "work with designation bucket" do
    bucket = create(:bucket, project: @project)
    post "/graphql",
      params: {
        query: query, 
        variables: {
          input: {
            title: "word!",
            bucketId: bucket.id,
            description: "word!",
            projectId: @project.id,
            priority: "p2",
            genre: "bug"
          }
        }
      }.to_json, headers: user_headers
    expect(Issue.first.bucket).to eq(bucket)
    expect(response.status).to eq 200
    expect(response.body).to include_json({
      data: {
        createIssue: {
          issue: {
            title: "word!",
            description: "word!",
            project: {
              id: @project.id
            },
            author: {
              id: @account.id
            },
            genre: "bug"
          }
        }
      }
    })
  end
end
