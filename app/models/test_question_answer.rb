class TestQuestionAnswer < ApplicationRecord
  validates_presence_of :test_question,
                        :test_question_variant,
                        :is_correct
  belongs_to :test_question_variant # крч хз пока как
  belongs_to :test_question
end
