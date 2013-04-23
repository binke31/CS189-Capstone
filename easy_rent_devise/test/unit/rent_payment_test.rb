require 'test_helper'

class RentPaymentTest < ActiveSupport::TestCase
    
  should validate_presence_of(:paymentAmount)
    
  should validate_presence_of(:routingNumber)
  should validate_numericality_of(:routingNumber).only_integer
  should ensure_length_of(:routingNumber).is_equal_to(9)
  
  should validate_presence_of(:accountNumber)
  should validate_numericality_of(:accountNumber).only_integer

  should validate_presence_of(:paymentDate)
  
  should validate_presence_of(:firstName)
  
  should validate_presence_of(:lastName)
  
  should validate_presence_of(:accountType)
  should validate_format_of(:accountType).with('checking')
  should validate_format_of(:accountType).not_with('Random')
    
end
