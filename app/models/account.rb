class Account < ApplicationRecord
  include JwtHelper
  validates :email, uniqueness: true
  has_secure_password
  has_many :memberships
  has_many :organizations, through: :memberships
  has_many :issues, as: :author
  has_many :issues, as: :assignee

  has_one_attached :avatar

  def login
    JWT.encode({
      account_id: id,
      created_at: DateTime.now.strftime("%Q")
    },
      Rails.application.credentials.secret_key_base)
  end

  def verify_account(code)
    if verify_code == code
      verify
    else
      errors.add(:verify_code, "This Verify Code is invalid!")
    end
  end

  def verify
    update(verified: true)
  end

  def verified?
    verified
  end

  def set_avatar(file)
    content_type = CommonFile.extract_content_type(file.tempfile.path)
    extension = file.original_filename.split(".").last.downcase
    file_size = file.tempfile.size
    if file_size > 1.megabytes
      errors.add(name, "avatar size should be less than 1MB")
    end
    unless %w[image/png image/jpg image/jpeg].include?(content_type) &&
        %w[png jpg jpeg].include?(extension)
      errors.add(name, "only support png/jpg/jpeg")
    end
    avatar.attach(
      io: file.tempfile,
      filename: file.original_filename,
      content_type: file.content_type
    )
  end
end
