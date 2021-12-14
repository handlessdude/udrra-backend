class TestQuestionVariant < ApplicationRecord
  belongs_to :test_user_answer
  has_one :test_question

  has_one :test_correct_answer # крч хз пока как
  has_one :test_question, through: :test_correct_answer

  validates_presence_of :test_question,
                        :title
end
