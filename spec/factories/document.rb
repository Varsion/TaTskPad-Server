FactoryBot.define do
  factory :document do
    title { Faker::Name.name }
    content { Faker::Lorem.sentence }
    knowledge_base

    after(:create) do |document|
      document.contributors << {id: create(:account).id}
      document.save
    end
  end
end
