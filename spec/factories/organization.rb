FactoryBot.define do
  factory :organization do
    name { Faker::Name.name + "ORG." }
    invite_code { Faker::Number.number(digits: 6) }
    email { Faker::Internet.email }
    organization_class { "Personal" }
  end
end