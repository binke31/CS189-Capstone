class NotificationSettings < ActiveRecord::Base
  
  after_initialize :init
  
  attr_accessible :userID, :phoneNumber, :textMessages, :emails, :rentOneDay, :rentOneWeek, :general, :maintenanceUpdates
  
  def init
    self.textMessages ||= "off"
    self.emails ||= "off"
    self.rentOneDay ||= "no"
    self.rentOneWeek ||= "no"
    self.general ||= "no"
    self.maintenanceUpdates ||= "no"
  end
  
end
