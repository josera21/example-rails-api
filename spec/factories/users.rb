FactoryGirl.define do
  factory :user do
    email "jose@correo.com"
    name "Jose"
    provider "Google"
    uid "123ejfjasbfajk1"
    factory :dummy_user do
    	email "rafael@correo.com"
	    name "Rafael"
	    provider "Facebook"
	    uid "123ejfjasbfajk1"
    end
    factory :sequence_user do
    	sequence(:email) { |n| "user#{n}@correo.com" }
    	name "Rafael"
	    provider "Facebook"
	    uid "123ejfjasbfajk1"
    end
  end
end
