class CreateNotificationsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications_users do |t|

      t.timestamps
    end
  end
end
