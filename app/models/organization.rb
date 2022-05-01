class Organization < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships
  has_one_attached :logo
  has_many :projects, dependent: :destroy
  has_many :roles, dependent: :destroy

  extend Enumerize
  enumerize :organization_class, in: [:Personal, :Business], default: :Personal
  enumerize :status, in: [:active, :archived], default: :active

  has_one :owner, -> { where(role: "owner") }, class_name: "Membership"
  has_many :admins, -> { where(role: "admin") }, class_name: "Membership"

  def upload_logo(file)
    return if file.nil?
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

  def is_owner?(account)
    owner.account == account
  end

  def is_admin?(account)
    admins.where(account: account).exists?
  end

  def is_member?(account)
    accounts.include?(account)
  end

  def archive!
    update(status: :archived)
  end

  def current_membership(account)
    account.memberships.find_by(organization_id: id)
  end

  def transfer_to(account)
    if is_owner?(account)
      errors.add(:base, "You can't transfer organization to yourself")
    elsif !is_member?(account)
      errors.add(:base, "You can't transfer organization to him if he is not a member of the organization")
    else
      owner.update(role: "admin")
      current_membership(account).update(role: "owner")
    end
  end
end