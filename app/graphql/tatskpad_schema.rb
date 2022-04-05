class TatskpadSchema < GraphQL::Schema
  class Query < Types::Base::Object
    field :account, resolver: Resolvers::AccountResolver
    field :organization, resolver: Resolvers::OrganizationResolver
    field :project, resolver: Resolvers::ProjectResolver
  end

  class Mutation < Types::Base::Object
    # Sessions related
    field :sign_up, resolver: Mutations::SignUp
    field :sign_in, resolver: Mutations::SignIn

    # Accounts related
    field :verify_account, resolver: Mutations::VerifyAccount
    field :update_account, resolver: Mutations::UpdateAccount

    # Organizations related
    field :create_organization, resolver: Mutations::CreateOrganization
    field :update_organization, resolver: Mutations::UpdateOrganization
    field :archive_organization, resolver: Mutations::ArchiveOrganization
    field :transfer_organization, resolver: Mutations::TransferOrganization

    # Projects related
    field :create_project, resolver: Mutations::CreateProject
    field :update_project, resolver: Mutations::UpdateProject
    # field :archive_project, resolver: Mutations::ArchiveProject
    field :update_workflow_steps, resolver: Mutations::UpdateWorkflowSteps
    field :update_customize_fields, resolver: Mutations::UpdateCustomizeFields

    # Tickets related
    # field :create_ticket, resolver: Mutations::CreateTicket
    # field :update_ticket, resolver: Mutations::UpdateTicket
  end

  query Query
  mutation Mutation
end
