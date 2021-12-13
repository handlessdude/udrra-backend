class CreateTestAnswerResults < ActiveRecord::Migration[6.1]
  def change
    create_table :test_answer_results do |t|
      t.references :test_question, null: false
      t.references :test_answer, null: false
      t.references :test, null: false
      t.boolean :is_correct, null: false
      t.timestamps
    end
  end
end
