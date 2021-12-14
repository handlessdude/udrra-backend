class TestCorrectAnswer < ApplicationRecord
  validates_presence_of :test_question,
                        :test_question_variant
  has_one :test_question_variant # крч хз пока как
  has_one :test_question
end
