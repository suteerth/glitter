class SessionsController < ApplicationController
  
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash[:error] = "Invalid email/password combo. Try again."
      redirect_to signin_path
    else
      # Sign the user in and redirect to user's show page
      sign_in user
      redirect_to user
    end                            
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
