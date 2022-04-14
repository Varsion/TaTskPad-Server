FactoryBot.define do
  factory :bucket do
    name { Faker::Name.name }
    project
  end
end