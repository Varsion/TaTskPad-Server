class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :author, foreign_key: { to_table: :accounts }
  belongs_to :assignee, foreign_key: { to_table: :accounts }

  extend Enumerize
  enumerize :priority, in: [:p0, :p1, :p2, :p3], default: :p2
  enumerize :type, in: [:story, :bug, :task, :subtask], default: :story

  class CustomizeFields
    include StoreModel::Model

    attribute :name, :string
    attribute :value, :string

    validates :name, presence: true
  end

  class Histories
    include StoreModel::Model
    attribute :operator, :string
    attribute :action, :string
    attribute :created_at, :datetime
  end

  attribute :customize_fields, CustomizeFields.to_array_type
  validates :customize_fields, store_model: { merge_errors: true }

  attribute :histories, Histories.to_array_type
  validates :histories, store_model: { merge_errors: true }
end
