class TatskpadSchema < GraphQL::Schema
  class Query < Types::Base::Object
    field :account, resolver: Resolvers::AccountResolver
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
  end

  query Query
  mutation Mutation
end
