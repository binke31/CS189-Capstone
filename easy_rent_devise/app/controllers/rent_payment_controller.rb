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
      # Following commented code would add the current time (in hours,mins,secs) to the paymentDate field of @rentPayment
      #time = Time.now
      #date = params[:rentPayment][:paymentDate].split("/")
      #@rentPayment.paymentDate = "20#{date[2]}/#{date[0]}/#{date[1]} #{time.hour}:#{time.min}:#{time.sec} #{time.zone}".to_datetime
	  @rentPayment.save
	  redirect_to "/home/", notice: "Rent payment successfully submitted!"
  end

end