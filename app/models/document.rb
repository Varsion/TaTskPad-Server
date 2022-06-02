class Document < ApplicationRecord
  belongs_to :knowledge_base

  class Contributor
    include StoreModel::Model
    attribute :id
    validates :id, presence: true
  end
  attribute :contributors, Contributor.to_array_type

  def archive!
    update(archived: true)
  end
end
