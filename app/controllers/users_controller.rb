class UsersController < ApplicationController
  load_and_authorize_resource
  
  before_filter :require_login, only: [:edit]
  
  def index
    @users = User.all
  end

  def show
    @user = User.where("lower(username) = ?", params[:username].downcase).first
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(current_user.id)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, flash: { success: 'User was successfully created.' }
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(current_user.id)

    if @user.authenticate(params[:old_password])
      params[:user] = params[:user].slice(:password, :password_confirmation)
      if @user.update_attributes(params[:user])
        redirect_to admin_url, flash: { success: 'User was successfully updated.' }
      else
        flash.now[:error] = "There was a problem saving your new password."
        render 'edit'
      end
    else
      flash.now[:error] = "There was a problem saving your new password."
      @password_error = true
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end
end
