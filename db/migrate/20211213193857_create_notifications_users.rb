class CreateNotificationsUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications_users do |t|
      t.references :notification, null: false
      t.references  :user, null: false
      t.boolean :looked, default: false
      t.timestamps
    end
  end
end
