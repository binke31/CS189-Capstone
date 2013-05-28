class User < ActiveRecord::Base
  
  belongs_to :property
  
  has_many :maintenance_requests, dependent: :destroy
  has_many :rent_payments, dependent: :destroy
  has_many :rent_notifications, dependent: :destroy
  has_many :maintenance_notifications, dependent: :destroy
  has_one :notification_settings, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :rentDueDay
  
  def getFullName()
    firstName + " " + lastName
  end
  
  def updateBalance!(amountPaid, datePaid)
    if Time.now >= datePaid
      self.currentBalance = (currentBalance.to_f - amountPaid).to_s
      self.save
    else
      # payment is in the future, need to wait to update balance until future date
    end
  end
  
  def self.updateUserBalancesForProperty!(propertyID)
    property = Property.find(propertyID)
    property.tenants.each do |user|
      user.currentBalance = property.getUserMonthlyPaymentAmount(user.getFullName())
      user.save
    end
  end
  
end
