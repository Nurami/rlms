module Learners
  class DashboardController < BaseController

    expose_decorated :course, decorator: LearnerCourseDecorator, find_by: :slug, id: :slug
    expose_decorated :courses, decorator: LearnerCourseDecorator, from: :current_learner
    

    def show
    end
  end
end
