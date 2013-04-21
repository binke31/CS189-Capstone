class UserRegistrationsController < Devise::RegistrationsController
  
  layout 'settingsPage'
    
  def edit
    super
  end
  
end