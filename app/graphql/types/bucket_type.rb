module Types
  class BucketType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: false
  end
end