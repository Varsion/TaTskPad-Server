module Types
  class SprintType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :version, String, null: false
    field :is_current, Boolean, null: false
    field :issue_list, BucketType, null: false

    def issue_list
      object.bucket
    end
  end
end
