class MaintenanceRequestController < ApplicationController

	layout "pageview"

    #GET /home/maintenance_request
    def new
      @mainRequest = MaintenanceRequest.new
    end

    #POST /home/maintenance_request
    def create
 	  # params[:maintenanceRequest] contains all request information
 	  @mainRequest = MaintenanceRequest.new(params[:mainRequest])
 	  @mainRequest.maintenanceRequestDate = Time.now
 	  @mainRequest.save
 	  redirect_to "/home/"
    end
end 
