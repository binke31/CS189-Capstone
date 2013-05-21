class NotificationMailer < ActionMailer::Base
  default from: "capstone.aer@gmail.com"
  
  def rentNotification(email, interval)
    @interval = interval
    mail(to: email, subject: "Rent Notification")
  end
  
  def maintenanceNotification(email, id)
    @maintenanceRequest = MaintenanceRequest.find(id)
    mail(to: email, subject: "Maintenance Notification: " + @maintenanceRequest.maintenanceRequestDate.strftime("%m/%d/%y"))
  end
  
end
