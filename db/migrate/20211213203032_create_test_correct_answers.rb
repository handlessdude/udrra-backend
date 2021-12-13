class CreateTestCorrectAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :test_correct_answers do |t|
      t.references :test_question, null: false
      t.references :test_question_variant, null: false
      t.timestamps
    end
  end
end
