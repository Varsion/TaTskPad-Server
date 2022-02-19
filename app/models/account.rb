class Account < ApplicationRecord
  include JwtHelper
  validates :email, uniqueness: true
  has_secure_password

  def login
    token = encode(self)
  end
end