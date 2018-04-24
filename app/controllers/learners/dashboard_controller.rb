module Learners
  class DashboardController < BaseController

    expose :course, find_by: :slug, id: :slug
    expose :courses, from: :current_learner
    
    def show; end
  end
end
