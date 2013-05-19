class RentPayment < ActiveRecord::Base
  
  belongs_to :user

  attr_accessible :paymentAmount, :routingNumber, :accountNumber, :paymentDate, :firstName, :lastName, :accountType, :savePayment

  validates_presence_of :paymentAmount, :routingNumber, :accountNumber, :paymentDate, :firstName, :lastName, :accountType
    
  validates :routingNumber, length: { is: 9 }, numericality: { only_integer: true }
    
  validates :accountNumber, numericality: { only_integer: true }
    
  validates :accountType, format: { with: /\A(checking)|(savings)\z/ }

end
