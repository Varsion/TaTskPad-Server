module Types
  class ErrorType < Types::Base::Object
    field :path, String, null: false
    field :message, String, null: false
  end
end