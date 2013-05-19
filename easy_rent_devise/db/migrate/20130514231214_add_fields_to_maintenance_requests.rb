class AddFieldsToMaintenanceRequests < ActiveRecord::Migration
  def change
    change_table(:maintenance_requests) do |t|
      t.string :status
    end
  end
end
