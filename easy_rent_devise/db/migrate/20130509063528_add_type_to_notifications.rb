class AddTypeToNotifications < ActiveRecord::Migration
  def change
    change_table(:notifications) do |t|
      t.string :type
    end
  end
end
