class Bucket < ApplicationRecord
  belongs_to :project
  has_many :issues
  has_one :sprint
end
