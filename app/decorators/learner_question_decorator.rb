class LearnerQuestionDecorator < ApplicationDecorator
  delegate_all

  def initialize(learner, question)
    @learner = learner
    @question = question
  end

  def answer_correct?
    @learner.learner_answer.where(question: @question).first.correct
  end

end
