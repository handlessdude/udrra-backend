class TracksUser < ApplicationRecord
  validates_presence_of :user_id,
                        :track_id,
                        :status,
                        :finished
  has_one :track
  has_one :user
end
