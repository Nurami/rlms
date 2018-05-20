class LearnerCourseDecorator < ApplicationDecorator
  #decorates :course
  delegate_all
  # decorates Learner::Course

  # def initialize (course)
  #   @course = course
  # end

  def result
    topics = object.topics
    arr = []
    topics.each do |topic|
      mass = []
      topic.questions.each do |question|
        mass.push(question.learner_answers.where(learner: h.current_learner).first.correct)
      end
      if mass.size != 0
        if (mass.count(true) / mass.size.to_f) >= 0.75
          arr.push(true)
        else
          arr.push(false)
        end
      end
    end
    if arr.size != 0
      ((arr.count(true) / arr.size.to_f) * 100).to_i
    else
      0
    end
  end

end
