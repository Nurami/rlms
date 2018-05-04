module Api
  module V1
    class TopicsController < Api::V1::BaseController
      respond_to :json

      TOPIC_PARAMS = %i[title description order_index].freeze

      expose :topic
      expose :course

      def index
        render json: course.topics.ordered_by_index
      end

      def update
        Teachers::Topics::UpdateOrderIndexes.call(topic: topic, new_index: topic_params["order_index"].to_i)

        topic.update_attributes(topic_params)
        topic.save

        respond_with topic
      end

      private

      def topic_params
        params.require(:topic).permit(*TOPIC_PARAMS)
      end
    end
  end
end
