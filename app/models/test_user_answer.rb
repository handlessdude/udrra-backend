class TestUserAnswer < ApplicationRecord
  belongs_to :test_answer_result
  has_one :test_question
  has_one :test_question_variant
  has_one :user

  validates_presence_of :user,
                        :test_question,
                        :test_question_variant
end
