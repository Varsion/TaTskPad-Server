module Types
  class BoardType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: true
    field :is_default, Boolean, null: false
    field :columns, [Types::WorkflowStepType], null: true
  end
end
