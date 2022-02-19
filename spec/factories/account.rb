FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "123456" }
  end
end