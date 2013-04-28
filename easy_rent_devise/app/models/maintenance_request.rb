class MaintenanceRequest < ActiveRecord::Base

	attr_accessible :maintenanceRequestDate, :writtenRequest,
	 				:userFirstName, :userLastName, :permissionToEnter
    
    validates_presence_of :maintenanceRequestDate, :writtenRequest, :permissionToEnter #,:userFirstName, :userLastName
    
    validates :writtenRequest, length: { maximum: 1000 }

end
