module Types
  module Inputs
    class CustomizeFieldInput < Types::Base::InputObject
      argument :name, String, required: true
      argument :type, String, required: true
    end
  end
end