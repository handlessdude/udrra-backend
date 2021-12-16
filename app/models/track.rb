class Track < ApplicationRecord
  validates_presence_of :track_name,
                        :preview_text,
                        :preview_picture,
                        :mode,
                        :published
  validates_uniqueness_of :track_name

  has_many :tracks_user, dependent: :destroy
  has_many :users, through: :tracks_user

  has_many :details_tracks, dependent: :destroy
  has_many :details, through: :details_tracks
end
