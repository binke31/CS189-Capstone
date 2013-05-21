class UserSessionsController < Devise::SessionsController
  
  layout 'login'
  
  #skip_before_filter :require_no_authentication, :only => [:new]
  
  def new
    super
  end
  
  /def create
    userHash = params[:user]
    s = CapstoneSession.create({:email => userHash[:email], :password => userHash[:password]})
    if s.persisted?
      if s.account_information_id?
        # then this user has saved payment information
      end
      super
    else
      render :new, alert: "Invalid tenant credentials."
    end
  end/
  
  def destroy
    session.clear
    if current_user
      current_user.forget_me! # ensures that if a user clicks remember me, they will still be logged out if they click log out
    end
    super
  end
  
end