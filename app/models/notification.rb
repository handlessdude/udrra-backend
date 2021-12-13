class Notification < ApplicationRecord
  validates_presence_of :text
  has_and_belongs_to_many :notifications_users
  has_and_belongs_to_many :users
end
