class TestQuestionVariant < ApplicationRecord
  validates_presence_of :test_question,
                        :title
  has_one :test_user_answer

  has_many :test_question_answers
  has_many :test_questions, through: :test_question_answers
end
