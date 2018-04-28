class AddDefaulfValueToCorrectInAnswers < ActiveRecord::Migration[5.1]
  def up
    change_column :answer_variants, :correct, :boolean, default: false
  end

  def down
    change_column :answer_variants, :correct, :boolean, default: nil
  end
end
