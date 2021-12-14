class CreateTestUserAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :test_user_answers do |t|
      t.references :user, null: false
      t.references :test_question, null: false
      t.references :test_question_variant, null: false
      t.timestamps
    end
  end
end
