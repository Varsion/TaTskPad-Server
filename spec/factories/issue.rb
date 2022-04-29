FactoryBot.define do
  factory :issue do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    key_number { Faker::Number.number(digits: 5) }
    customize_fields do
      context = []
      context << { name: "test", type: "string", value: "test" }
      context
    end
    author
    project
  end
end