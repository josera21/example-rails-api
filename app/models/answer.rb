class Answer < ApplicationRecord
  belongs_to :question
  validates :description, presence: true
  validates :question, presence: true
end
