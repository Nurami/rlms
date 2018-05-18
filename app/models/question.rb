class Question < ApplicationRecord
  belongs_to :topic

  has_many :answer_variants, dependent: :destroy
  has_many :learner_answers

  validates :title, presence: true
end
