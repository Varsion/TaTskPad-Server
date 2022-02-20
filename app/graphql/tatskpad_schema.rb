class TatskpadSchema < GraphQL::Schema
  class Query < Types::Base::Object
  end

  class Mutation < Types::Base::Object
    field :sign_up, resolver: Mutations::SignUp
    field :sign_in, resolver: Mutations::SignIn
    field :create_org, resolver: Mutations::CreateOrg
  end

  query Query
  mutation Mutation
end
