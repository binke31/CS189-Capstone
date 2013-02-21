class UserUnlocksController < Devise::UnlocksController
  layout 'login'
  
  def new
    super
  end
  
end