module Types
  class HistoryType < Types::Base::Object
    field :operator, String, null: false
    field :action, String, null: false
    field :created_at, String, null: false
  end
end
