FactoryBot.define do
  factory :board do
    name { Faker::Name.name }
    project
  end
end