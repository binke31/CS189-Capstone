class MaintenanceRequest < ActiveRecord::Base
  
  belongs_to :user
  
  after_update :sendMaintenanceNotification, if: :status_changed?

	attr_accessible :maintenanceRequestDate, :writtenRequest,
	 				:userFirstName, :userLastName, :permissionToEnter, :status
    
  validates_presence_of :maintenanceRequestDate, :writtenRequest, :permissionToEnter #,:userFirstName, :userLastName
    
  validates :writtenRequest, length: { maximum: 1000 }
  
  def sendMaintenanceNotification
    NotificationMailer.maintenanceNotification(user.email, id).deliver
  end

end
