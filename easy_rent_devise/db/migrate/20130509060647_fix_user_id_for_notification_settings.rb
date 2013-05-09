class FixUserIdForNotificationSettings < ActiveRecord::Migration
  def change
    rename_column :notification_settings, :userID, :user_id
  end
end
