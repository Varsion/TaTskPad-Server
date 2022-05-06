module Types
  class BucketType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :is_release, Boolean, null: false
    field :issues, [Types::IssueType], null: true
    field :sprint, Types::SprintType, null: true
  end
end
