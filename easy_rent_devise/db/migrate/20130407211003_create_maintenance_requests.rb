class CreateMaintenanceRequests < ActiveRecord::Migration
  def change
    create_table :maintenance_requests do |t|     
      t.timestamps
      t.string :maintenanceRequest
      t.datetime :maintenanceRequestDate
      t.string :writtenRequest
	  t.string :userFirstName
	  t.string :userLastName
	  t.string :permissionToEnter
    end
  end
end
