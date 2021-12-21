class User < ApplicationRecord
  validates_presence_of :login,
                        :email,
                        :password_digest,
                        :first_name,
                        :second_name

  validates_uniqueness_of :login, :email

  has_many :notifications_users, dependent: :destroy
  has_many :notifications, through: :notifications_users

  has_many :tracks_users, dependent: :destroy
  has_many :tracks, through: :tracks_users

  has_many :test_user_answers, dependent: :destroy

  belongs_to :faculty, optional: true

  has_and_belongs_to_many :roles
  before_destroy { roles.clear }

end
