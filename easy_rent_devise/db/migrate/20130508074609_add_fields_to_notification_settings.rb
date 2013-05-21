class AddFieldsToNotificationSettings < ActiveRecord::Migration
  def change
    change_table(:notification_settings) do |t|
      t.datetime :sendNextRentAt
      t.string :rentInterval
    end
  end
end
