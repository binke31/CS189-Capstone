class FixNotificationMessageForNotifications < ActiveRecord::Migration
  def change
    rename_column :notifications, :notificationMessage, :message
  end
end
