class LearnerAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :answer_variant
  belongs_to :learner
end
