class TatskpadSchema < GraphQL::Schema
  class Query < Types::Base::Object
    field :account, resolver: Resolvers::AccountResolver
    field :organization, resolver: Resolvers::OrganizationResolver
    field :project, resolver: Resolvers::ProjectResolver
    field :issue, resolver: Resolvers::IssueResolver
    field :knowledge_base, resolver: Resolvers::KnowledgeBaseResolver
    field :role, resolver: Resolvers::RoleResolver
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

    # Members related
    # field :invite_member, mutation: Mutations::InviteMember

    # Role related
    field :create_role, mutation: Mutations::CreateRole
    # field :update_role, mutation: Mutations::UpdateRole

    # Projects related
    field :create_project, mutation: Mutations::CreateProject
    field :update_project, mutation: Mutations::UpdateProject
    field :archive_project, mutation: Mutations::ArchiveProject
    field :update_workflow_steps, mutation: Mutations::UpdateWorkflowSteps
    field :update_customize_fields, mutation: Mutations::UpdateCustomizeFields

    # # Issues related
    field :create_issue, mutation: Mutations::CreateIssue
    field :update_issue, mutation: Mutations::UpdateIssue

    # # Buckets related
    field :create_bucket, mutation: Mutations::CreateBucket
    field :update_bucket, mutation: Mutations::UpdateBucket

    # # Comments related
    field :create_comment, mutation: Mutations::CreateComment
    field :update_comment, mutation: Mutations::UpdateComment
    field :delete_comment, mutation: Mutations::DeleteComment

    # # Knowledge base related
    field :create_knowledge_base, mutation: Mutations::CreateKnowledgeBase
    field :update_knowledge_base, mutation: Mutations::UpdateKnowledgeBase
    field :archive_knowledge_base, mutation: Mutations::ArchiveKnowledgeBase

    # # Documents related
    field :create_document, mutation: Mutations::CreateDocument
    field :update_document, mutation: Mutations::UpdateDocument
    field :archive_document, mutation: Mutations::ArchiveDocument

    # # Kanban board related
    field :create_board, mutation: Mutations::CreateBoard
    field :update_board, mutation: Mutations::UpdateBoard

    # # Sprint related
    field :create_sprint, mutation: Mutations::CreateSprint
    field :start_sprint, mutation: Mutations::StartSprint
    field :end_sprint, mutation: Mutations::EndSprint
  end

  query Query
  mutation Mutation
end
