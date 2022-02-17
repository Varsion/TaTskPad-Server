class Organization < ApplicationRecord::Base
  has_many :users
  has_one :owner, -> { where(is_owner: true) }, class_name: 'User'
end