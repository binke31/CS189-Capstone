class HomeController < ApplicationController
  
  #layout "application"
  
  before_filter :authenticate_user!
  
  #GET /home
  def show
    # stub
  end
  
end