class MaintenanceRequest < ActiveRecord::Base

	attr_accessible :maintenanceRequest, :maintenanceRequestDate, :writtenRequest,
	 				:userFirstName, :userLastName, :permissionToEnter 

end
