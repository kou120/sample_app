class SessionsController < ApplicationController
  def new
  end
  
  def create
    # Search users by email address 
    user = User.find_by(email: params[:session][:email].downcase)
    # Verify password match
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      # create error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
