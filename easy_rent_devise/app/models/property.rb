class Property < ActiveRecord::Base
  
  has_many :tenants, class_name: "User"
  
  attr_accessible :address, :monthlyPayment, :rentDivisionEnabled, :rentDivisions
  
  def getUserMonthlyPaymentAmount(userName)
    rentDivisions.split("/").each do |division|
      divisionArray = division.split(":")
      if (divisionArray[0] == userName)
        return divisionArray[1]
      end
    end
  end
  
  def getTotalRentAccountedFor()
    total = 0
    tenants.each do |tenant|
      tenantRent = getUserMonthlyPaymentAmount(tenant.getFullName())
      if tenantRent != "null"
        total += tenantRent.to_f
      end
    end
    total
  end
  
  def updateRentDivisionForUser!(userName, rentAmount)
    updatedRentDivisions = ""
    rentDivisions.split("/").each do |division|
      divisionArray = division.split(":")
      updatedRentDivisions << divisionArray[0] + ":"
      if (divisionArray[0] == userName)
        updatedRentDivisions << rentAmount
      else
        updatedRentDivisions << divisionArray[1]
      end
      updatedRentDivisions << "/"
    end
    self.rentDivisions = updatedRentDivisions.chomp("/")
    if shouldEnableRentDivision?
      self.rentDivisionEnabled = "yes"
    else
      self.rentDivisionEnabled = "no"
    end
    self.save
  end
  
  def shouldEnableRentDivision?
    if getTotalRentAccountedFor() != monthlyPayment
      return false
    end
    rentDivisions.split("/").each do |division|
      divisionArray = division.split(":")
      if (divisionArray[1] == "null")
        return false
      end
    end
    
    return true
  end
  
end
