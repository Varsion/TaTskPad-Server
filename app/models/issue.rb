class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: "Account", foreign_key: :author_id
  belongs_to :assignee, class_name: "Account", foreign_key: :assignee_id, optional: true
  has_many :comments, dependent: :destroy

  extend Enumerize
  enumerize :priority, in: [:p0, :p1, :p2, :p3], default: :p2
  enumerize :genre, in: [:story, :bug, :task, :subtask], default: :story

  class CustomizeFields
    include StoreModel::Model

    attribute :name, :string
    attribute :type, :string
    attribute :value, :string

    validates :name, presence: true
    validates :type, presence: true
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
