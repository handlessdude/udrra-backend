class Test < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :instruction,
                        :duration,
                        :img
  belongs_to :detail, as: :entity
end
