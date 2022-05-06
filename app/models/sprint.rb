class Sprint < ApplicationRecord
  belongs_to :project
  belongs_to :bucket
end
