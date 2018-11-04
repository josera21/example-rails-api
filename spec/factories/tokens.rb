FactoryGirl.define do
  factory :token do
    expires_at "2017-12-19 15:53:16"
    association :user, factory: :user
  end
end
