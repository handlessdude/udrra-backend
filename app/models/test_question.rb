class TestQuestion < ApplicationRecord
  validates_presence_of :test_id,
                        :question_type,
                        :name,
                        :description,
                        :img
  belongs_to :test

  has_many :test_question_answer, dependent: :destroy
  has_many :test_question_variant,
           through: :test_question_answer

  has_many :test_user_answers, dependent: :destroy
end
