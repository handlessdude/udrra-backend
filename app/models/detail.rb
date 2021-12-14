class Detail < ApplicationRecord
  validates_presence_of :type,
                        :entity_name,
                        :entity_duration,
                        :entity
  belongs_to :entity, polymorphic: true

  has_many :details_tracks
  has_many :tracks, through: :details_tracks

end
