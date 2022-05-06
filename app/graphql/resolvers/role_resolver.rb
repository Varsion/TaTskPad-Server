module Resolvers
  class RoleResolver < BaseResolver
    type Types::RoleType, null: true

    argument :id, ID, required: true
    def resolve(id:)
      authenticate_user!
      Role.find_by(id: id)
    end
  end
end
