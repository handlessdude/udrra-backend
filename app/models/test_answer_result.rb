class TestAnswerResult < ApplicationRecord
  validates_presence_of :test_question_id,
                        :test_answer_id,
                        :test_id,
                        :is_correct
  has_one :test_user_answer
  has_one :test_question
  has_one :test
end
