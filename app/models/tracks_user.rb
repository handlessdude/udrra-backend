class TracksUser < ApplicationRecord
  validates_presence_of :track,
                        :user,
                        :status

  belongs_to :track
  belongs_to :user
end
