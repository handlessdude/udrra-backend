class TestUserAnswer < ApplicationRecord
  belongs_to :test_question
  belongs_to :test_question_variant
  belongs_to :user

  validates_presence_of :user,
                        :test_question,
                        :test_question_variant
end
