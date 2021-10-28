class TatskpadSchema < GraphQL::Schema
  class QueryType < Types::Base::Object
    field :subscriptions, resolver: Resolvers::TestResolver 
  end
  class MutationType < Types::Base::Object

  end
end
