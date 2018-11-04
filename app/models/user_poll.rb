class UserPoll < ApplicationRecord
  belongs_to :user
  belongs_to :my_poll
end
