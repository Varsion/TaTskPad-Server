class Project < ApplicationRecord
  belongs_to :organization
  has_one_attached :logo
  has_many :buckets, dependent: :destroy
  has_many :knowledge_bases, dependent: :destroy
  after_create :create_default_knowledge_base
  has_one :default_knowledge_base, -> { where(is_default: true) }, class_name: "KnowledgeBase"

  extend Enumerize
  enumerize :status, in: [:active, :archived], default: :active
  enumerize :version_format, in: [:semver], default: :semver
  enumerize :project_class, in: [:software], default: :software

  validates_uniqueness_of :key_word, scope: :organization_id

  class WorkflowSteps
    include StoreModel::Model

    attribute :name, :string
    attribute :description, :string

    validates :name, presence: true
  end

  class CustomizeFields
    include StoreModel::Model

    attribute :name, :string
    attribute :type, :string
    attribute :value, :string

    validates :name, presence: true
    validates :type, presence: true

    enum :type, in: { string: "string", text: "text", integer: "integer", boolean: "boolean" }, default: :string
  end

  attribute :workflow_steps, WorkflowSteps.to_array_type
  attribute :customize_fields, CustomizeFields.to_array_type

  validates :workflow_steps, store_model: { merge_errors: true }
  validates :customize_fields, store_model: { merge_errors: true }


  def init_workflow_steps
    self.workflow_steps = [
      { name: "Todo", description: "to do" },
      { name: "Doing", description: "Doing" },
      { name: "Done", description: "Done" }
    ]
  end

  def upload_logo(file)
    return if file.nil?
    content_type = CommonFile.extract_content_type(file.tempfile.path)
    extension = file.original_filename.split(".").last.downcase
    file_size = file.tempfile.size
    if file_size > 1.megabytes
      errors.add(name, "logo size should be less than 1MB")
    end
    unless %w[image/png image/jpg image/jpeg].include?(content_type) &&
        %w[png jpg jpeg].include?(extension)
      errors.add(name, "only support png/jpg/jpeg")
    end
    logo.attach(
      io: file.tempfile,
      filename: file.original_filename,
      content_type: file.content_type
    )
  end

  def archive!
    self.status = :archived
    save!
  end

  def create_default_knowledge_base
    knowledge_base = KnowledgeBase.create(
      title: name + "'s Knowledge Base",
      project_id: id,
      is_default: true
    )
  end
end
