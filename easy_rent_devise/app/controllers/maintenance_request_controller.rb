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
 	    @mainRequest.attributes = {
 	      maintenanceRequestDate: Time.now,
 	      status: "Submitted",
 	      userFirstName: current_user.firstName,
 	      userLastName: current_user.lastName
 	    }
 	    @mainRequest.save
 	    redirect_to "/home/", notice: "Maintenance request successfully submitted!"
    end
    
    #GET /home/maintenance_log
    def index
      # stub
    end
    
    #GET /home/maintenance_log/<id>
    def show
      @mainRequest = MaintenanceRequest.find(params[:id])
    end
    
end 
