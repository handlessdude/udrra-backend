class TestQuestionVariant < ApplicationRecord
  validates_presence_of :title
  has_many :test_user_answer, dependent: :destroy

  has_many :test_question_answers, dependent: :destroy
  has_many :test_questions, through: :test_question_answers
end
