module Types
  class TestType < Types::Base::Object
    field :id, String, null: false
    field :name, String, null: true
  end
end