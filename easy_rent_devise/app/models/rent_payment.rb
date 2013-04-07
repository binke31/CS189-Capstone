class RentPayment < ActiveRecord::Base

  attr_accessible :paymentAmount, :routingNumber, :accountNumber, :paymentDate, :firstName, :lastName, :accountType, :savePayment

  

end
