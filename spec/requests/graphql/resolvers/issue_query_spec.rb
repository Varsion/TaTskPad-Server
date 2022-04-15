# frozen_string_literal: true

require "rails_helper"

RSpec.describe "GraphQL - Issue Query", type: :request do
  before :each do
    @account = create(:account)
    @organization = create(:organization)
    @project = create(:project, organization: @organization)
    create(:membership, account: @account, organization: @organization, role: "owner")

    @issue = create(:issue, project: @project, author: @account)
  end

  let(:query) do
    "
    query issue($issueId: ID!) {
      issue(issueId: $issueId) {
        id
        title
        description
        genre
        priority
        customizeFields {
          name
          value
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
          issueId: @issue.id
        }
      }.to_json, headers: user_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          issue: {
            id: @issue.id,
            customizeFields: [{
              name: "test",
              value: "test"
            }]
          }
        }
      })
  end

  context "comments" do
    before :each do
      @comment = create(:comment, issue: @issue, account: @account)
    end

    let(:query) do
      "
      query issue($issueId: ID!) {
        issue(issueId: $issueId) {
          id
          title
          comments {
            content
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
            issueId: @issue.id
          }
        }.to_json, headers: user_headers
      expect(response.status).to eq 200
      expect(response.body).to include_json({
        data: {
          issue: {
            id: @issue.id,
            comments: [{
              content: @comment.content
            }]
          }
        }
      })
    end
  end
end