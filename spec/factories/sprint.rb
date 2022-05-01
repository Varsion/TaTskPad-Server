FactoryBot.define do
  factory :sprint do
    name { Faker::Name.name }
    version { Faker::Number.number(digits: 2) }
    is_current { false }
    project
  end
end