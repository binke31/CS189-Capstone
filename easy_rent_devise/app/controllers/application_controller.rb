class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :instantiateUser
    helper :application
  
  def instantiateUser
    @user = User.new
  end
  
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      "/home"
    else
      super
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      "/login"
    else
      super
    end
  end
  
end
