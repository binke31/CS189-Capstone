class NotificationSettings < ActiveRecord::Base
  
  belongs_to :user
  
  after_initialize :init
  
  attr_accessible :phoneNumber, :textMessages, :emails, :rentOneDay, :rentOneWeek, :general, :maintenanceUpdates, :sendNextRentAt, :rentInterval
  
  def init
    self.textMessages ||= "off"
    self.emails ||= "off"
    self.rentOneDay ||= "off"
    self.rentOneWeek ||= "off"
    self.general ||= "off"
    self.maintenanceUpdates ||= "off"
  end
  
end
