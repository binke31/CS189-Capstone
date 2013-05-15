class MaintenanceRequest < ActiveRecord::Base
  
  belongs_to :user
  
  after_update :sendMaintenanceNotification, if: :status_changed?

	attr_accessible :maintenanceRequestDate, :writtenRequest,
	 				:userFirstName, :userLastName, :permissionToEnter, :status
    
  validates_presence_of :maintenanceRequestDate, :writtenRequest, :permissionToEnter #,:userFirstName, :userLastName
    
  validates :writtenRequest, length: { maximum: 1000 }
  
  def sendMaintenanceNotification
    if user.notification_settings.maintenanceUpdates == "on"
      
      if user.notification_settings.emails == "on"
        NotificationMailer.maintenanceNotification(user.email, id).deliver
      end
      
      if user.notification_settings.textMessages == "on"
        sendTextMessage(user.notification_settings.phoneNumber, "The status of your maintenance request that was submitted on " + 
                                                                maintenanceRequestDate.strftime("%m/%d/%y") + " by " + userFirstName + " " +
                                                                userLastName + " has changed to " + status + "."
                       )
      end
      
    end
  end

  def sendTextMessage(numberToSendTo, textMessageBody)
    twilio_sid = "AC44d7376dc48f735adf59d7a242f87963"
    twilio_token = "30cb912b711e15d31ec41aa2f7d2fcc7"
    twilio_phone_number = "2094424289"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => numberToSendTo,
      :body => textMessageBody
    )
  end

end
