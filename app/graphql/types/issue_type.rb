module Types
  class IssueType < Types::Base::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :project, Types::ProjectType, null: false
    field :author, Types::AccountType, null: false
    field :assignee, Types::AccountType, null: true
    field :genre, String, null: false
    field :priority, String, null: false
    field :estimate, String, null: true
    field :customize_fields, [Types::CustomizeFieldType], null: true
    field :histories, [Types::HistoryType], null: true
    field :comments, [Types::CommentType], null: true
  end
end
