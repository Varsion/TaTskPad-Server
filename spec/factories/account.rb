FactoryBot.define do
  factory :account, aliases: [:author] do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    verify_code { Faker::Number.number(digits: 6) }
    password { "123456" }
  end
end