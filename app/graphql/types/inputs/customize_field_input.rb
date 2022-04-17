module Types
  module Inputs
    class CustomizeFieldInput < Types::Base::InputObject
      argument :name, String, required: true
      argument :type, String, required: true
      argument :value, String, required: false
    end
  end
end