class Event < ApplicationRecord
  validates_presence_of :name,
                        :duration
  validates_uniqueness_of :name

  has_many :detail, as: :entity
end
