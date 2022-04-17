class Document < ApplicationRecord
  belongs_to :knowledge_base

  class Contributors
    include StoreModel::Model
    attribute :id
    validates :id, presence: true
  end
  attribute :contributors, Contributors.to_array_type

end