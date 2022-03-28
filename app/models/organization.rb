class Organization < ApplicationRecord
  has_many :memberships
  has_many :accounts, through: :memberships
  has_one_attached :logo

  extend Enumerize
  enumerize :organization_class, in: [:Personal, :Business], default: :Personal

  has_one :owner, -> { where(role: "owner") }, class_name: "Membership"
  has_many :admins, -> { where(role: "admin") }, class_name: "Membership"

  def upload_logo(file)
    content_type = CommonFile.extract_content_type(file.tempfile.path)
    extension = file.original_filename.split(".").last.downcase
    file_size = file.tempfile.size
    if file_size > 1.megabytes
      errors.add(name, "logo size should be less than 1MB")
    end
    unless %w[image/png image/jpg image/jpeg].include?(content_type) &&
        %w[png jpg jpeg].include?(extension)
      errors.add(name, "only support png/jpg/jpeg")
    end
    logo.attach(
      io: file.tempfile,
      filename: file.original_filename,
      content_type: file.content_type
    )
  end

  def set_owner(account)
    memberships.create(account: account, role: "owner")
  end

  def the_owner
    owner.account
  end

  def is_owner?(account)
    owner.account == account
  end

  def is_admin?(account)
    admins.where(account: account).exists?
  end

  def is_member?(account)
    accounts.include?(account)
  end
end