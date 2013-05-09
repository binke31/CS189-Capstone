class AddFieldsToNotifications < ActiveRecord::Migration
  def change
    change_table :notifications do |t|
      t.integer :user_id
      t.string :notificationMessage
    end
  end
end
