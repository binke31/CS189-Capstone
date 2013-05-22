class MaintenanceRequestController < ApplicationController

	layout :resolve_layout

    #GET /home/maintenance_request
    def new
      @mainRequest = MaintenanceRequest.new
=begin
This is used to test the sending of maintenance requests without appfolio backend
      maintenanceRequest = current_user.maintenance_requests.first
      if !maintenanceRequest.nil?
        maintenanceRequest.status = "Fixed"
        maintenanceRequest.save
      end
=end
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
 	    if @mainRequest.valid?
 	      permission = @mainRequest.permissionToEnter == "Yes" ? '1' : '0'
 	      #sendMaintenanceToAppfolio(@mainRequest.writtenRequest, permission)
 	      @mainRequest.save
 	      redirect_to "/home/", notice: "Maintenance request successfully submitted!"
 	    else
 	      render :new
 	    end
    end
    
    def sendMaintenanceToAppfolio(description, permission)
      CapstoneMaintenance.create(
        :email => current_user.email,
        :tenant_description => description,
        :permission_to_enter => permission
      )
    end
    
    #GET /home/maintenance_log
    def index
      @maintenanceRequests = current_user.maintenance_requests.all
    end
    
    #GET /home/maintenance_log/<id>
    def show
      @mainRequest = MaintenanceRequest.find(params[:id])
    end
    
    private
      def resolve_layout
        case action_name
        when 'show'
          'nestedPageview'
        else
          'pageview'
        end
      end
    
end 
