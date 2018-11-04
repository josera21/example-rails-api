FactoryGirl.define do
  factory :my_app do
    association :user, factory: :user
    title "MyString"
    javascript_origins "MyString"
  end
end
