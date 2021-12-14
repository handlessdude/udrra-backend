class Test < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :instruction,
                        :duration,
                        :img
  has_one :detail, as: :entity
  has_many :test_questions
  has_many :test_answer_results
end
