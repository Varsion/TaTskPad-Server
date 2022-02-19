module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::Base::Argument
    field_class Types::Base::Field
    input_object_class Types::Base::InputObject
    object_class Types::Base::Object

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
