class PropertyInfoController < ApplicationController
  
  layout :resolve_layout
  
  #GET /home/my_info
  def show
    @property = current_user.property
  end
  
  #GET /home/rent_division
  def edit
    @property = current_user.property
    @roomates = @property.tenants.select{ |tenant| tenant.email != current_user.email }
  end
  
  #PUT /home/rent_division
  def update
    @property = current_user.property
    if params[:rentAmount].to_f > 0 && params[:rentAmount].to_f <= @property.monthlyPayment.to_f
      @property.updateRentDivisionForUser!(current_user.getFullName(), params[:rentAmount])
      if @property.rentDivisionEnabled == "yes"
        User.updateUserBalancesForProperty!(@property.id)
        redirect_to "/home", notice: "Successfully configured individual rent division settings! Rent division settings finalized."
      else
        redirect_to "/settings/rent_division_settings", notice: "Successfully configured individual rent division settings! Still waiting on other roommates to finalize your settings."
      end
    else
      redirect_to "/settings/rent_division_settings", alert: "Invalid rent amount. Must be a valid number between 0 and " + @property.monthlyPayment.to_s
    end
  end
  
  private
    def resolve_layout
      case action_name
      when 'edit'
        'settingsPage'
      else
        'pageview'
      end
    end
  
end
