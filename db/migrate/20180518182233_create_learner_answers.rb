class CreateLearnerAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :learner_answers do |t|
      t.references :question, foreign_key: true
      t.references :answer_variant, foreign_key: true
      t.references :learner, foreign_key: true

      t.timestamps
    end
  end
end
