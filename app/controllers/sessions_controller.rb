class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])
    if !@user.nil? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to cars_path
    else
      incorrect_credentials
    end
  end

  private

  def incorrect_credentials
    flash[:alert] = 'Incorrect username and/or password'
    redirect_to login_path
  end
end
