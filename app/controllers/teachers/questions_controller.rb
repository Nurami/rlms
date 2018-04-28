module Teachers
  class QuestionsController < BaseController
    respond_to :js

    expose :question
    expose :topic

    def create  
      uploaded = params.require(:question).permit(:attachment)
      if uploaded.has_key?(:attachment)
        uploaded_io = uploaded[:attachment]
        xls = Roo::Spreadsheet.open(uploaded_io)
        @questions = Array.new
        xls.each_row_streaming(offset: 1) do |row|
          q = Question.new(title: row[0])
          q.answer_variants << AnswerVariant.new(text: row[1], correct: true)
          q.topic = topic
          row.slice!(0,2)
          row.each do |answ|
            q.answer_variants << AnswerVariant.new(:text => answ)
          end 
          @questions << q 
        end
        return
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
      for q in params[:questions] do
        quest = Question.new(title: q[:title])
        quest.topic = topic
        if quest.valid?
          for a in q[:answers] do
            if a[:text]
              quest.answer_variants << AnswerVariant.new(text: a[:text], correct: a[:correct])
            end
          end
          quests << quest
        end
      end
      Question.transaction do
        quests.each(&:save)
      end
      redirect_to  teachers_topic_path(topic) 
    end 

    private

    def question_params
      params.require(:question).permit(:title)
    end
  end
end
