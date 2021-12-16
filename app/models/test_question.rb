class TestQuestion < ApplicationRecord
  validates_presence_of :test_id,
                        :type,
                        :name,
                        :description,
                        :img
  belongs_to :test

  has_many :test_question_answer
  has_many :test_question_variant,
           through: :test_question_answer
end
