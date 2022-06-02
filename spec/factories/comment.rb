FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    account
    issue
  end
end
