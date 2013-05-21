class AddUseridToMaintenanceRequests < ActiveRecord::Migration
  def change
    change_table(:maintenance_requests) do |t|
      t.integer :user_id
    end
  end
end
