class UsersController < ApplicationController
  before_action :require_admin

  def edit
    @user = User.find_by owner: true
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      flash[:success] = 'You have updated your profile.'
      redirect_to root_path
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :summary, :portrait)
  end
end
