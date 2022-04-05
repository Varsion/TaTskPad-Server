class TatskpadSchema < GraphQL::Schema
  class Query < Types::Base::Object
    field :account, resolver: Resolvers::AccountResolver
    field :organization, resolver: Resolvers::OrganizationResolver
    field :project, resolver: Resolvers::ProjectResolver
    # field :issue, resolver: Resolvers::IssueResolver
    # field :bucket, resolver: Resolvers::BucketResolver
    # field :comment, resolver: Resolvers::CommentResolver
  end

  class Mutation < Types::Base::Object
    # Sessions related
    field :sign_up, mutation: Mutations::SignUp
    field :sign_in, mutation: Mutations::SignIn

    # Accounts related
    field :verify_account, mutation: Mutations::VerifyAccount
    field :update_account, mutation: Mutations::UpdateAccount

    # Organizations related
    field :create_organization, mutation: Mutations::CreateOrganization
    field :update_organization, mutation: Mutations::UpdateOrganization
    field :archive_organization, mutation: Mutations::ArchiveOrganization
    field :transfer_organization, mutation: Mutations::TransferOrganization

    # Projects related
    field :create_project, mutation: Mutations::CreateProject
    field :update_project, mutation: Mutations::UpdateProject
    field :archive_project, mutation: Mutations::ArchiveProject
    field :update_workflow_steps, mutation: Mutations::UpdateWorkflowSteps
    field :update_customize_fields, mutation: Mutations::UpdateCustomizeFields

    # Issues related
    # field :create_issue, mutation: Mutations::CreateIssue
    # field :update_issue, mutation: Mutations::UpdateIssue

    # Buckets related
    # field :create_bucket, mutation: Mutations::CreateBucket
    # field :update_bucket, mutation: Mutations::UpdateBucket

    # Comments related
    # field :create_comment, mutation: Mutations::CreateComment
    # field :update_comment, mutation: Mutations::UpdateComment
    # field :delete_comment, mutation: Mutations::DeleteComment
  end

  query Query
  mutation Mutation
end
