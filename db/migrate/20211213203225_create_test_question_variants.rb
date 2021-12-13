class CreateTestQuestionVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :test_question_variants do |t|
      t.references :test_question, null: false
      t.string :title, null: false
      t.timestamps
    end
  end
end
