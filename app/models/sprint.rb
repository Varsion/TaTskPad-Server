class Sprint < ApplicationRecord
  belongs_to :project
  has_one :bucket
  after_create :create_sprint_bucket

  def create_sprint_bucket
    Bucket.create(
      name: "#{self.name} #{self.version}",
      project_id: project_id,
      sprint_id: id,
      is_backlog: false,
      is_release: true
    )
  end
end
