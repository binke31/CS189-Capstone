class NotificationSettingsController < ApplicationController
  
	layout "settingsPage"
	
	#GET /settings/notification_settings
	def edit
	  @notificationSettings = current_user.notification_settings
	end
	
	#PUT /settings/notification_settings
	def update
	  @notificationSettings = current_user.notification_settings
	  newAttributes = params[:notificationSettings]
	  
	  if @notificationSettings.emails == "off" && @notificationSettings.textMessages == "off" && (params[:notificationSettings][:emails] == "on" || params[:notificationSettings][:textMessages] == "on")
	    sendNextRentDate, rentInterval = getNextDateToSendRentNotification(params[:notificationSettings])
	    newAttributes = newAttributes.merge({ sendNextRentAt: sendNextRentDate, rentInterval: rentInterval })
	  elsif (@notificationSettings.emails == "on" || @notificationSettings.textMessages == "on") && (params[:notificationSettings][:emails] == "off" && params[:notificationSettings][:textMessages] == "off")
	    newAttributes = newAttributes.merge({ sendNextRentAt: nil, rentInterval: "" })
	  end
	  
	  if @notificationSettings.update_attributes(newAttributes)
	    redirect_to user_root_path, notice: "Notification settings successfully updated!"
	  else
	    render "edit"
	  end
	end
	
	#RETURNS: Array object where first entry is a Time object representing the date and the second entry is a string (either "week" or "day")
	def getNextDateToSendRentNotification(newSettings)
	  oneDayDate = nil
    oneWeekDate = nil
    if newSettings[:rentOneDay] == "on"
      oneDayDate = NotificationSettingsController.findNextSendRentNotificationDate("day", current_user.rentDueDay)
    end
    if newSettings[:rentOneWeek] == "on"
      oneWeekDate = NotificationSettingsController.findNextSendRentNotificationDate("week", current_user.rentDueDay)
    end
    if (oneDayDate.nil?)
      [oneWeekDate, "week"]
    elsif (oneWeekDate.nil?)
      [oneDayDate, "day"]
    else
      if oneWeekDate < oneDayDate
        [oneWeekDate, "week"]
      else #oneDayDate < oneWeekDate
        [oneDayDate, "day"]
      end
    end
	end
	
	#RETURNS: Time object representing the date that was calculated, hour set to midnight (i.e. beginning of day)
	def self.findNextSendRentNotificationDate(rentInterval, rentDueDay)
	  today = Time.zone.now
	  
	  if rentInterval == "day"  
      if rentDueDay == 1
        today.end_of_month.change(hour: 0)
      else
        if rentDueDay-1 >= today.strftime("%d").to_f
          today.change(day: rentDueDay-1, hour: 0)
        else
          if (today.month+1 == 2) && (rentDueDay > 29)
            rentDueDay = 29
          end
          
          today.change(month: today.month+1, day: rentDueDay-1, hour: 0)
        end
      end
      
    else #rentInterval == "week"
      nextReminderDay = (rentDueDay - 7) % 31
      
      if nextReminderDay == 0
        nextReminderDay = 31
      end
      
      if nextReminderDay >= today.strftime("%d").to_f
        today.change(day: nextReminderDay, hour: 0)
      else
        if (today.month+1 == 2) && (nextReminderDay > 28)
          nextReminderDay = 28
        elsif ((today.month+1 == 4) || (today.month+1 == 6) || (today.month+1 == 9) || (today.month+1 == 11)) && (nextReminderDay > 30)
          nextReminderDay = 30
        end
        
        today.change(month: today.month+1, day: nextReminderDay, hour: 0)
      end
    end
	end
	
	def self.sendTextMessage(numberToSendTo, textMessageBody)
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
	
	def self.cronjob
	  today = Time.zone.now
	  puts "NotificationSettingsController.cronjob started at " + today.to_s
	  rentNotificationsToSend = NotificationSettings.where(sendNextRentAt: (today - 1.day)..(today))
	  rentNotificationsToSend.each do |settings|
	    current_user = User.find(settings.user_id)
	    rentDueDay = current_user.rentDueDay
	    rentInterval = settings.rentInterval
	    
	    rentMessage = "Your rent is due one " + rentInterval + " from today (" + today.strftime("%m/%d/%y") + ")."
	    if settings.emails == "on"
	      NotificationMailer.rentNotification(current_user.email, rentInterval).deliver
	      puts "Just sent rent notification to " + current_user.email + " at " + Time.zone.now.to_s
	    end
	    if settings.textMessages == "on"
	      NotificationSettingsController.sendTextMessage(settings.phoneNumber, rentMessage)
	      puts "Just sent rent notification to " + settings.phoneNumber + " at " + Time.zone.now.to_s
	    end
	    current_user.rent_notifications.create(message: rentMessage).save
	    
	    if (settings.rentOneDay == "on") && ((rentInterval == "week") || (settings.rentOneWeek == "off"))
	      rentInterval = "day"
	    else
	      rentInterval = "week"
	    end
	    
	    settings.sendNextRentAt = NotificationSettingsController.findNextSendRentNotificationDate(rentInterval, rentDueDay)
	    settings.rentInterval = rentInterval
	    if settings.save
	      puts "Just successfully updated " + current_user.email + "'s :sendNextRentAt notification settings to " + settings.sendNextRentAt.to_s + " at " + Time.now.to_s
	    else
	      puts "Just failed to update " + current_user.email + "'s :sendNextRentAt notification settings to " + settings.sendNextRentAt.to_s + " at " + Time.now.to_s
	    end
	    
	  end
	end
  
end
