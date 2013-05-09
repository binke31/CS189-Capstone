class NotificationSettingsController < ApplicationController
  
	layout "settingsPage"
	
	#GET /settings/notification_settings
	def edit
	  @notificationSettings = NotificationSettings.where(userID: current_user.id).first
	end
	
	#PUT /settings/notification_settings
	def update
	  @notificationSettings = NotificationSettings.where(userID: current_user.id).first
	  if @notificationSettings.update_attributes(params[:notificationSettings])
	    redirect_to user_root_path, notice: "Notification settings successfully updated!"
	  else
	    render "edit"
	  end
	end
	
	def self.cronjob
	  today = Time.zone.now
	  puts "NotificationSettingsController.cronjob started at " + today.to_s
	  rentNotificationsToSend = NotificationSettings.where(sendNextRentAt: (today - 1.day)..(today))
	  rentNotificationsToSend.each do |settings|
	    current_user = User.find(settings.userID)
	    NotificationMailer.rentNotification(current_user.email, settings.rentInterval).deliver
	    puts "Just sent rent notification to " + current_user.email + " at " + Time.now.to_s
	    rentDueDay = current_user.rentDueDay
	    rentInterval = settings.rentInterval
	    if (settings.rentOneDay == "on") && ((rentInterval == "week") || (settings.rentOneWeek == "off"))
	      rentInterval = "day"
	    else
	      rentInterval = "week"
	    end
	    if rentInterval == "day"
	      if rentDueDay == 1
	        settings.sendNextRentAt = today.end_of_month.change(hour: 0)
	      else
	        if rentDueDay-1 > today.strftime("%d")
	          settings.sendNextRentAt = today.change(day: rentDueDay-1, hour: 0)
	        else
	          if (today.month+1 == 2) && (rentDueDay > 29)
	            rentDueDay = 29
	          end
	          settings.sendNextRentAt = today.change(month: today.month+1, day: rentDueDay-1, hour: 0)
	        end
	      end
	    else #rentInterval == "week"
	      nextReminderDay = (current_user.rentDueDay - 7) % 31
	      if nextReminderDay == 0
	        nextReminderDay = 31
	      end
	      if nextReminderDay > today.strftime("%d").to_f
	        settings.sendNextRentAt = today.change(day: nextReminderDay, hour: 0)
	      else
	        if (today.month+1 == 2) && (nextReminderDay > 28)
	          nextReminderDay = 28
	        elsif ((today.month+1 == 4) || (today.month+1 == 6) || (today.month+1 == 9) || (today.month+1 == 11)) && (nextReminderDay > 30)
	          nextReminderDay = 30
	        end
	        settings.sendNextRentAt = today.change(month: today.month+1, day: nextReminderDay, hour: 0)
	      end
	    end
	    settings.rentInterval = rentInterval
	    if settings.save
	      puts "Just successfully updated " + current_user.email + "'s :sendNextRentAt notification settings to " + settings.sendNextRentAt.to_s + " at " + Time.now.to_s
	    else
	      puts "Just failed to update " + current_user.email + "'s :sendNextRentAt notification settings to " + settings.sendNextRentAt.to_s + " at " + Time.now.to_s
	    end
	  end
	end
  
end
