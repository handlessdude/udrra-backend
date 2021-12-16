class User < ApplicationRecord
  validates_presence_of :login,
                        :encrypted_password,
                        :first_name,
                        :second_name,
                        :faculty
  validates_uniqueness_of :login

  has_many :notifications_users, dependent: :destroy
  has_many :notifications, through: :notifications_users

  has_many :tracks_users, dependent: :destroy
  has_many :tracks, through: :tracks_users

  has_many :test_user_answers, dependent: :destroy

  belongs_to :faculty

end
