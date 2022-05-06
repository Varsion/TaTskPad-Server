module Types
  class ProjectType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :project_class, String, null: false
    field :status, String, null: false
    field :logo_url, String, null: true
    field :key_word, String, null: true
    field :code_url, String, null: true
    field :current_sprint, Types::SprintType, null: true
    field :buckets, [Types::BucketType], null: true
    field :knowledge_base, [Types::KnowledgeBaseType], null: true
    field :customize_fields, [Types::CustomizeFieldType], null: false
    field :workflow_steps, [Types::WorkflowStepType], null: false

    def logo_url
      object.logo.attached? ? Rails.application.routes.url_helpers.url_for(object.logo) : ""
    end
  end
end
