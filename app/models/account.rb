class Account < ApplicationRecord
  include JwtHelper
  validates :email, uniqueness: true
  has_secure_password
  has_many :members
  has_many :organizations, through: :members

  def login
    token = encode(self)
  end

  def verify_account(code)
    if verify_code == code
      update(verified: true)
    else
      errors.add(:verify_code, "This Verify Code is invalid!")
    end
  end
end