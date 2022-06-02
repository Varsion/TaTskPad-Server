module Types
  class AccountType < Types::Base::Object
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: false
    field :token, String, null: true
    field :verified, Boolean, null: false
    field :avatar, String, null: true
    field :organizations, [Types::OrganizationType], null: true

    def avatar
      object.avatar.attached? ?
        Rails.application.routes.url_helpers.url_for(object.avatar) :
        "https://ui-avatars.com/api/?name=#{object.name}"
    end
  end
end
