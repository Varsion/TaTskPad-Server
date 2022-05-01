module Types
  class OrganizationType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :logo_url, String, null: false
    field :organization_class, String, null: false
    field :status, String, null: false
    field :owner, Types::AccountType, null: false
    field :projects, [Types::ProjectType], null: false
    field :roles, [Types::RoleType], null: false

    def logo_url
      object.logo.attached? ? Rails.application.routes.url_helpers.url_for(object.logo) : ""
    end

    def owner
      object.owner.account
    end
  end
end