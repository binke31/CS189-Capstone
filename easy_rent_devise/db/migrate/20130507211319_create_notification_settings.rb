class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.integer :userID
      t.string :phoneNumber
      t.string :textMessages
      t.string :emails
      t.string :rentOneDay
      t.string :rentOneWeek
      t.string :general
      t.string :maintenanceUpdates
      t.timestamps
    end
  end
end
