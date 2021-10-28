module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    protected

    def authenticate_user!
      raise GraphQL::ExecutionError, 'unauthenticated' unless context[:user]
    end
  end
end
  