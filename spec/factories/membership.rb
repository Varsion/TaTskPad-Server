FactoryBot.define do
  factory :membership do
    account_id { create(:account).id }
    organization_id { create(:organization).id }
    role { "member" }
  end
end