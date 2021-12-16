class NotificationsUser < ApplicationRecord
  validates_presence_of :notification,
                        :user

  belongs_to :notification
  belongs_to :user
end
