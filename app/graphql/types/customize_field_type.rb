module Types
  class CustomizeFieldType < Types::Base::Object
    field :name, String, null: false
    field :type, String, null: false
    field :value, String, null: true
  end
end
