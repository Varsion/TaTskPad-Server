module Types
  class OrganizationType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :logo_url, String, null: false
    field :organization_class, String, null: false

    def logo_url
      object.logo.attached? ? Rails.application.routes.url_helpers.url_for(object.logo) : ""
    end
  end
end