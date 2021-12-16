class CreateTestQuestionAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :test_question_answers do |t|
      t.references :test_question, null: false
      t.references :test_question_variant, null: false
      t.boolean :is_correct, null: false
      t.timestamps
    end
  end
end
