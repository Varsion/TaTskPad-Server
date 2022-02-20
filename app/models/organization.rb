class Organization < ApplicationRecord
  has_many :accounts
  has_one :owner, -> { where(is_owner: true) }, class_name: "Account"
  has_one_attached :logo
  extend Enumerize

  enumerize :organization_class, in: [:Personal, :Business], default: :Personal

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
end