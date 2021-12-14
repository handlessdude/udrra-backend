class NotificationsUser < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  validates_presence_of :looked,
                        :notification,
                        :user
end
