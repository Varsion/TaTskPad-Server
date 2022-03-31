FactoryBot.define do
  factory :project do
    name { Faker::Name.name }
    key_word { "FAKER" }
    organization
    
    after(:create) do |project|
      project.init_workflow_steps
      project.save
    end
  end
end