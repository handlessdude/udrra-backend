class TracksUser < ApplicationRecord
  belongs_to :track
  belongs_to :user

  validates_presence_of :track,
                        :user,
                        :status,
                        :finished
end
