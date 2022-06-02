module Types
  module Inputs
    class WorkflowStepInput < Types::Base::InputObject
      argument :name, String, required: true
      argument :description, String, required: false
    end
  end
end
