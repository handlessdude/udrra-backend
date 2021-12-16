class TestQuestionAnswer < ApplicationRecord
  validates_presence_of :test_question,
                        :test_question_variant,
                        :is_correct
  belongs_to :test_question_variant
  belongs_to :test_question

  has_many :test_user_answers
end
