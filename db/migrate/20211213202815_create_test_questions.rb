class CreateTestQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :test_questions do |t|
      t.references :test, null: false
      t.string :question_type, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.string :img, null: false
      t.timestamps
    end
  end
end
