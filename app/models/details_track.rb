class DetailsTrack < ApplicationRecord
  belongs_to :track
  belongs_to :detail

  validates_presence_of :detail,
                        :track,
                        :finished,
                        :assigned
end
