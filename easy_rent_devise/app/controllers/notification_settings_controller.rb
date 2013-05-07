class NotificationSettingsController < ApplicationController
  
	layout "pageview"
	
	#GET /settings/notification_settings
	def edit
	  @notificationSettings = NotificationSettings.where(userID: current_user.id).first
	end
	
	#PUT /settings/notification_settings
	def update
	  #stub
	end
  
end
