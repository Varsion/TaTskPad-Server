FactoryBot.define do
  factory :issue do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    customize_fields do
      context = []
      context << { name: "test", type: "string", value: "test" }
      context
    end
    author
    project
  end
end