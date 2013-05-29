class RentPaymentController < ApplicationController

  layout :resolve_layout

  #GET /home/pay_rent
  def new
	 @rentPayment = RentPayment.new
  end
	
  #POST /home/pay_rent
  def create
	  @rentPayment = current_user.rent_payments.new(params[:rentPayment])
	  
      # Following commented code would add the current time (in hours,mins,secs) to the paymentDate field of @rentPayment
      #time = Time.now
      #date = params[:rentPayment][:paymentDate].split("/")
      #@rentPayment.paymentDate = "20#{date[2]}/#{date[0]}/#{date[1]} #{time.hour}:#{time.min}:#{time.sec} #{time.zone}".to_datetime
      
	  if @rentPayment.valid?
      @rentPayment.save
      #sendPaymentToAppfolio(current_user.email, @rentPayment)
      RentPaymentMailer.successfulPayment(current_user.email, @rentPayment.id).deliver
      current_user.updateBalance!(@rentPayment.paymentAmount.to_f, @rentPayment.paymentDate)
      redirect_to "/home/", notice: "Rent payment successfully submitted!"
    else
      render :new
    end
  end
	
	#GET /home/payment_history
	def index
	  @myRentPayments = current_user.rent_payments
	  @roomateRentPayments = []
	  roomates = current_user.property.tenants.select{ |tenant| tenant.email != current_user.email }
	  roomates.each do |tenant|
	    @roomateRentPayments += tenant.rent_payments
	  end
	  @myRentPayments.sort_by!{ |payment| payment.paymentDate }.reverse!
	  @roomateRentPayments.sort_by!{ |payment| payment.paymentDate }.reverse!
	  #@rentPayments = CapstonePayment.find(:all, :params => { :email_address => "blah@blah.com" })
=begin
	  @userPayments = []
	  @roommatePayments = []
	  rentPayments.each do |payment|
	    if payment.remote_payment.user_name == (current_user.firstName + " " + current_user.lastName)
	      @userPayments << payment
	    else
	      @roommatePayments << payment
	    end
	  end
=end
	end
	
	#GET /home/payment_history/<id>
	def show
		@rentPayment = RentPayment.find(params[:id])
		#@rentPayment = CapstonePayment.find(:first, :params => { :confirmation => params[:id] })
	end
  
  def sendPaymentToAppfolio(email, payment)
    newPayment = CapstonePayment.create({
      :email => email,
      :use_saved_info => false,
      :payment_amount => payment.paymentAmount,
      :payment_date => payment.paymentDate,
      :first_name => payment.firstName,
      :last_name => payment.lastName,
      :account_type => payment.accountType,
      :routing_number => payment.routingNumber.to_s,
      :account_number => payment.accountNumber.to_s,
      :save_payment => payment.savePayment
    })
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