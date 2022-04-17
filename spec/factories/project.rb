FactoryBot.define do
  factory :project do
    name { Faker::Name.name }
    key_word { "FAKER" }
    customize_fields { [{ name: "test", type: "string" }] }
    organization
    
    after(:create) do |project|
      project.init_workflow_steps
    end
  end
end