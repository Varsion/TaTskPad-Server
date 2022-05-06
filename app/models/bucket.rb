class Bucket < ApplicationRecord
  belongs_to :project
  has_many :issues
  belongs_to :sprint, optional: true
end
