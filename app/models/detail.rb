class Detail < ApplicationRecord
  validates_presence_of :detail_type,
                        :entity_name,
                        :entity
  belongs_to :entity, polymorphic: true

  has_many :details_tracks, dependent: :destroy
  has_many :tracks, through: :details_tracks

end
