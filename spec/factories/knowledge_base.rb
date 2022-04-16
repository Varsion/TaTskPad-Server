FactoryBot.define do
  factory :knowledge_base do
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    project
  end
end