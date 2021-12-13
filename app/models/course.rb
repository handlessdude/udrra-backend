class Course < ApplicationRecord
  validates_presence_of :name,
                        :duration
  belongs_to :detail, as: :entity
end
