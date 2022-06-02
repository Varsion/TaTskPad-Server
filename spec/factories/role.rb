FactoryBot.define do
  factory :role do
    name { Faker::Name.name.downcase }
    description { Faker::Lorem.sentence }
    organization
  end
end
