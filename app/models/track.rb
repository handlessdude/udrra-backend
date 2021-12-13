class Track < ApplicationRecord
  validates_presence_of :track_name,
                        :preview_text,
                        :preview_picture,
                        :mode,
                        :published
  belongs_to :details_track
  belongs_to :tracks_user
end
