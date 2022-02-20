class Member < ApplicationRecord
  belongs_to :organization
  belongs_to :account
  extend Enumerize
  enumerize :role, in: [:owner, :admin, :member], default: :member
end