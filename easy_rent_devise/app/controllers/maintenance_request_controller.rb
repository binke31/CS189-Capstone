class MaintenanceRequestController < ApplicationController

	layout "pageview"

    #GET /home/maintenance_request
    def new
      @mainRequest = MaintenanceRequest.new
    end

    #POST /home/maintenance_request
    def create
 	    # params[:maintenanceRequest] contains all request information
 	    @mainRequest = current_user.maintenance_requests.new(params[:mainRequest])
 	    @mainRequest.maintenanceRequestDate = Time.now
 	    @mainRequest.status = "Submitted"
 	    @mainRequest.save
 	    redirect_to "/home/", notice: "Maintenance request successfully submitted!"
    end
end 
