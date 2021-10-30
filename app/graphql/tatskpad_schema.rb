class TatskpadSchema < GraphQL::Schema
  class Query < Types::Base::Object
    field :hello, resolver: Resolvers::TestResolver
  end

  class Mutation < Types::Base::Object

  end

  query Query
  mutation Mutation
end
