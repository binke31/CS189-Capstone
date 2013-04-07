class RentPaymentController < ApplicationController

  layout "pageview"

  #GET /home/pay_rent
  def new
	 @rentPayment = RentPayment.new
  end
	
  #POST /home/pay_rent
  def create
	  
  end

end