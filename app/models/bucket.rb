class Bucket < ApplicationRecord
  belongs_to :project
  belongs_to :sprint
  has_many :issues
end
