class Organization < ApplicationRecord
  has_many :accounts
  has_one :owner, -> { where(is_owner: true) }, class_name: "Account"
end