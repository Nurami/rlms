class LearnerAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :answer_variant
  belongs_to :learner

  delegate :correct, to: :answer_variant
end
