class Role < ApplicationRecord
  belongs_to :organization
  before_save :scope_consistent

  validates :name, presence: true, uniqueness: { scope: :organization_id }

  class Permissions
    include StoreModel::Model

    attribute :scope, :string
    attribute :actions, :array_of_strings
  end

  attribute :permissions, Permissions.to_array_type
  validates :permissions, store_model: {merge_errors: true}

  def abilities
    permission_scopes = []
    Rails.application.config.permission_scopes.each do |scope|
      permission =
        permissions.find { |permission|
          permission.scope == scope[:scope]
        }

      permission_scopes <<
        {
          scope: scope[:scope],
          actions:
            (
              Rails.application.config.permission_default_actions +
                scope[:actions].to_a
            ).uniq.each_with_object([]) do |action, actions|
              actions <<
                {
                  key: action,
                  value: permission&.actions&.include?(action) == true
                }
            end
        }
    end
    permission_scopes
  end

  private

  def scope_consistent
    permissions.map do |permission|
      actions = permission.actions.to_a
      if actions.blank? || actions.include?("unavailable")
        permission.actions = %w[unavailable]
      end
    end
  end
end
