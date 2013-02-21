class UserSessionsController < Devise::SessionsController
  
  layout 'login'
  
  #skip_before_filter :require_no_authentication, :only => [:new]
  
  def new
    super
  end
  
  def destroy
    session.clear
    if current_user
      current_user.forget_me! # ensures that if a user clicks remember me, they will still be logged out if they click log out
    end
    super
  end
  
end