FactoryBot.define do
  factory :issue do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    author
    project
  end
end