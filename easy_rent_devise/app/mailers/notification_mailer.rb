class NotificationMailer < ActionMailer::Base
  default from: "capstone.aer@gmail.com"
  
  def rentNotification(email, interval)
    @interval = interval
    mail(to: email, subject: "Rent Notification")
  end
  
end
