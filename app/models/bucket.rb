class Bucket < ApplicationRecord
  belongs_to :project
  belongs_to :sprint, optional: true
  has_many :issues
end
