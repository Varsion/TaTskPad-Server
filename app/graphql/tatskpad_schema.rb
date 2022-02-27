class TatskpadSchema < GraphQL::Schema
  class Query < Types::Base::Object
    field :account, resolver: Resolvers::AccountResolver
  end

  class Mutation < Types::Base::Object
    field :sign_up, resolver: Mutations::SignUp
    field :sign_in, resolver: Mutations::SignIn
    field :create_org, resolver: Mutations::CreateOrg
    field :verify_account, resolver: Mutations::VerifyAccount
    field :update_account, resolver: Mutations::UpdateAccount
  end

  query Query
  mutation Mutation
end
