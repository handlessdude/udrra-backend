class Notification < ApplicationRecord
  validates_presence_of :text,
                        :created_at

  has_many :notifications_users, dependent: :destroy
  has_many :users, through: :notifications_users
end
