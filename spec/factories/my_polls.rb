FactoryGirl.define do
  factory :my_poll do
    association :user, factory: :sequence_user
    expires_at "2017-12-21 14:40:22"
    title "MyStringaa"
    description "MyTexttsafasfasfsa sfasjfsa fasfjsaofj"
    factory :poll_with_questions do
    	title "Poll with questions"
    	description "MyTexttsafasfasfsa asad sfasjfsa fasfjsaofj"
    	questions { build_list :question, 2 }
    end
  end
end
