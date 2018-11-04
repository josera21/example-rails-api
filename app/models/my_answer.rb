class MyAnswer < ApplicationRecord
  belongs_to :user_poll
  belongs_to :answer
end
