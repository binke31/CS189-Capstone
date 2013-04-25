class UserRegistrationsController < Devise::RegistrationsController
  
  layout 'settingsPage'
    
  def edit
    @user = current_user
  end

  def update_user
    @user = User.find(current_user.id)
    if params[:user][:password] != "" && params[:user][:email] != ""
      if @user.update_attributes(params[:user])
        # Sign in the user by passing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to user_root_path, notice: "Account Settings Updated Successfully!"
      else
        render "edit"
      end
    elsif params[:user][:password] == "" && params[:user][:email] != ""
      if @user.update_attributes(email: params[:user][:email])
        # Sign in the user by passing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to user_root_path, notice: "Account Settings Updated Successfully!"
      else
        render "edit"
      end
    elsif params[:user][:password] != "" && params[:user][:email] == ""
      if @user.update_attributes(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
        # Sign in the user by passing validation in case his password changed
        sign_in @user, :bypass => true
        redirect_to user_root_path, notice: "Account Settings Updated Successfully!"
      else
        render "edit"
      end
    else
      flash[:error] = "You can't submit a blank form!"
      render :edit
    end
  end
  
end