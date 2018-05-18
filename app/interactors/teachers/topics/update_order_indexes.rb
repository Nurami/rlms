module Teachers
  module Topics
    class UpdateOrderIndexes
      include Interactor

      delegate :topic, :new_index, to: :context

      def call
        return if invalid_index

        update_indexes
      end

      private

      def update_indexes
        if new_index > old_index
          decrement_indexes_of_next_topics
        else
          increment_indexes_of_previous_topics
        end

        topic.update(order_index: new_index)
      end

      def decrement_indexes_of_next_topics
        course_topics[old_index + 1..new_index].each { |t| t.decrement!(:order_index) }
      end

      def increment_indexes_of_previous_topics
        course_topics[new_index..old_index - 1].each { |t| t.increment!(:order_index) }
      end

      def course_topics
        @course_topics ||= Topic.where(course: topic.course).ordered_by_index
      end

      def invalid_index
        new_index == old_index || course_topics[new_index].nil?
      end

      def old_index
        topic.order_index
      end
    end
  end
end
