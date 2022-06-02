class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :bucket, optional: true
  belongs_to :author, class_name: "Account", foreign_key: :author_id
  belongs_to :assignee, class_name: "Account", foreign_key: :assignee_id, optional: true
  has_many :comments, dependent: :destroy
  after_create :throw_in_backlog

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
  validates :customize_fields, store_model: {merge_errors: true}

  attribute :histories, Histories.to_array_type
  validates :histories, store_model: {merge_errors: true}

  def throw_in_backlog
    return if bucket_id.present?
    self.bucket_id = project.backlog.id
    save
  end

  def generate_key_number
    count = project.issues.count
    project.key_word + "-" + (count + 1).to_s
  end
end
