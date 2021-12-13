class Detail < ApplicationRecord
  validates_presence_of :type,
                        :entity_name,
                        :entity_duration,
                        :entity_id
  has_one :entity, polymorphic: true #а сколько
end
