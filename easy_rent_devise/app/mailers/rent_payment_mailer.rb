class RentPaymentMailer < ActionMailer::Base
  default from: "capstone.aer@gmail.com"
  
  def successfulPayment(email, paymentID)
    @payment = RentPayment.find(paymentID)
    mail(to: email, subject: "Rent Payment Confirmation")
  end
  
end
