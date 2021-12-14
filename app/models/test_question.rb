class TestQuestion < ApplicationRecord
  validates_presence_of :test_id,
                        :type,
                        :name,
                        :description,
                        :img
  belongs_to :test

  belongs_to :test_correct_answer #крч хз пока как
  has_one :test_question_variant,
           through: :test_correct_answers
end
