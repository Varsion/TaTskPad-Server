class Sprint < ApplicationRecord
  belongs_to :project
  has_one :bucket
end
