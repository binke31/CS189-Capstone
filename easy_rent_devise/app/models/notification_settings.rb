class NotificationSettings < ActiveRecord::Base
  
  after_initialize :init
  
  attr_accessible :userID, :phoneNumber, :textMessages, :emails, :rentOneDay, :rentOneWeek, :general, :maintenanceUpdates, :sendNextRentAt
  
  def init
    self.textMessages ||= "off"
    self.emails ||= "off"
    self.rentOneDay ||= "off"
    self.rentOneWeek ||= "off"
    self.general ||= "off"
    self.maintenanceUpdates ||= "off"
  end
  
end
