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
	    #NOTE: this is probably where we will need to set up all of the notifications to be eventually sent out
	    redirect_to user_root_path, notice: "Notification settings successfully updated!"
	  else
	    render "edit"
	  end
	end
  
end
