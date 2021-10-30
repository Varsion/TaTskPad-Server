module Resolvers
  class TestResolver < BaseResolver
    type Types::TestType, null: false

    def resolve
      TestData.first
    end
  end
end
