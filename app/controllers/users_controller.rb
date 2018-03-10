class UsersController < ApplicationController
  def edit
    @user = User.first
  end

  def update
  end
end
