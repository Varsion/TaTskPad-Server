module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    protected

    def authenticate_user!
      raise GraphQL::ExecutionError, "unauthenticated" unless current_account
    end

    private

    def current_account
      @current_account ||= context[:account]
    end
  end
end
