class RentPaymentController < ApplicationController

  layout "pageview"

  #GET /home/pay_rent
  def new
	 @rentPayment = RentPayment.new
  end
	
  #POST /home/pay_rent
  def create
	  # params[:rentPayment] should have all the form input
	  @rentPayment = RentPayment.new(params[:rentPayment])
	  @rentPayment.save
	  redirect_to "/home/"
  end

end