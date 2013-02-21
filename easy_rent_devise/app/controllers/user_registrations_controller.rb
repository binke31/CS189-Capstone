class UserRegistrationsController < Devise::RegistrationsController
  
  layout 'login'
  
  #skip_before_filter :require_no_authentication, :only => [:new, :create]
  
end