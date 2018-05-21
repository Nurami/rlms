class LearnerCourseDecorator < ApplicationDecorator
  delegate_all
  delegate :topics, to: :object

  def result
    arr = topics.map do |topic|
      mass = topic.questions.map do |question|
        question.learner_answers.where(learner: h.current_learner).first.correct
      end
      topic_progress(mass) if mass.any?
    end
    percent(arr)
  end


  def percent(arr)
    return 0 if arr.empty?
    ((arr.count(true) / arr.size.to_f) * 100).to_i
  end

  def topic_progress(mass)
    (mass.count(true) / mass.size.to_f) >= 0.75
  end

end
