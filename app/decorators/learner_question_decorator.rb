class LearnerQuestionDecorator < ApplicationDecorator
  delegate_all

  def initialize(learner, question)
    @learner = learner
    @question = question
  end

  def answer_correct?
    learner_answer.correct
  end

  def answer_text
    learner_answer.text
  end

  def learner_answer
    @learner.learner_answers.where(question: @question).first
  end

end
