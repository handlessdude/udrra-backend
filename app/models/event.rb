class Event < ApplicationRecord
  validates_presence_of :name
  belongs_to :detail, as: :entity
end
