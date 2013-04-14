class MaintenanceRequest < ActiveRecord::Base

	attr_accessible :maintenanceRequestDate, :writtenRequest,
	 				:userFirstName, :userLastName, :permissionToEnter 

end
