class AnswerVariant < ApplicationRecord
  belongs_to :question

  has_many :learner_answers

  validates_presence_of :text
end
