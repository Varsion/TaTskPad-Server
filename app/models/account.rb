class Account < ApplicationRecord
  include JwtHelper
  validates :email, uniqueness: true
  has_secure_password
  has_many :members
  has_many :organizations, through: :members

  def login
    token = encode(self)
  end
end