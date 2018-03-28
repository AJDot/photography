class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Login successful. Welcome, #{@user.name}!"
      redirect_to home_path
    else
      flash[:danger] = "Incorrect email or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out. Goodbye!"
    redirect_to home_path
  end
end