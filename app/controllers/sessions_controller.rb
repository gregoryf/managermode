class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(active: true).find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, flash: { success: 'You have successfully logged in!'}
    else
      flash.now[:error] = "Invalid username or password."
      render "new"
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      redirect_to root_url, flash: { succes: 'Logged out.' }
    else
      render "new"
    end
  end
end
