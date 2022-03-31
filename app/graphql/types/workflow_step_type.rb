module Types
  class WorkflowStepType < Types::Base::Object
    field :name, String, null: false
    field :description, String, null: true
  end
end
