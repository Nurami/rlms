module Teachers
  class QuestionsController < BaseController
    respond_to :js

    expose :question
    expose :topic

    def create  
      uploaded = params.require(:question).permit(:attachment)
      if uploaded.has_key?(:attachment)
        @questions = Array.new
        uploaded_io = uploaded[:attachment]
        if uploaded_io.content_type.in?(%w(application/vnd.openxmlformats-officedocument.spreadsheetml.sheet application/vnd.oasis.opendocument.spreadsheet text/csv))
          xls = Roo::Spreadsheet.open(uploaded_io)
          xls.sheet(0).each do |row|
            if row[0].in?(['questions', nil])
              next
            end
            q = Question.new(title: row[0])
            q.answer_variants << AnswerVariant.new(text: row[1], correct: true)
            q.topic = topic
            row.slice!(0,2)
            row.each do |answ|
              if answ
                q.answer_variants << AnswerVariant.new(:text => answ)
              end
            end 
            @questions << q 
          end
          return
        end
        redirect_to  teachers_topic_path(topic), :alert => 'wrong format'
      end
      question.topic = topic
      question.save
    end

    def destroy
      question.destroy
    end

    def save
      params.permit(:topic_id, questions: [:title, {answers: [:text, :correct] } ])
      quests = Array.new

      params[:questions].each do |q|
        quest = Question.new(title: q[:title])
        quest.topic = topic
        q[:answers].each do |a|
          quest.answer_variants << AnswerVariant.new(text: a[:text], correct: a[:correct])
        end
        quests << quest
      end
      quests.each(&:save)
      redirect_to  teachers_topic_path(topic) 
    end 

    private

    def question_params
      params.require(:question).permit(:title)
    end
  end
end
