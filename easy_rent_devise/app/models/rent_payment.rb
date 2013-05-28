class RentPayment < ActiveRecord::Base
  
  before_save :generateUniqueConfirmationNumber
  
  belongs_to :user

  attr_accessible :paymentAmount, :routingNumber, :accountNumber, :paymentDate, :firstName, :lastName, :accountType, :savePayment
  
  attr_protected :confirmationNumber

  validates_presence_of :paymentAmount, :routingNumber, :accountNumber, :paymentDate, :firstName, :lastName, :accountType
    
  validates :routingNumber, length: { is: 9 }, numericality: { only_integer: true }
  validate :valid_routing_check_sum?
    
  validates :accountNumber, numericality: { only_integer: true }
    
  validates :accountType, format: { with: /\A(checking)|(savings)\z/ }

  def routing_check_sum
    rNumber = routingNumber.to_s
    return nil unless rNumber.match(/^[\d]{8,9}$/)

    digits = rNumber.split(//)
    part1 = (digits[0].to_i + digits[3].to_i + digits[6].to_i) * 3
    part2 = (digits[1].to_i + digits[4].to_i + digits[7].to_i) * 7
    part3 = digits[2].to_i + digits[5].to_i
    checkdigit = (10 - ((part1 + part2 + part3) % 10)) % 10
    puts checkdigit.to_s
    checkdigit.to_s
  end

  def valid_routing_check_sum?
    correct_checksum = routing_check_sum
    if correct_checksum.blank?
      errors.add(:routingNumber, "has invalid format")
    elsif (correct_checksum != routingNumber.to_s.split(//)[8])
      errors.add(:routingNumber, "has invalid format")
    end
  end
  
  def generateUniqueConfirmationNumber
    self.confirmationNumber = loop do
      random_number = SecureRandom.urlsafe_base64
      break random_number unless RentPayment.where(confirmationNumber: random_number).exists?
    end
  end

end
