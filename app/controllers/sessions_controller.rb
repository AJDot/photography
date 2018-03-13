class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    @user = User.first
    @session = Session.new(session_params)
    @session.creator = @user
    if @session.save
      flash[:success] = 'You have created a session.'
      redirect_to root_path
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :new
    end
  end

  private

  def session_params
    params.require(:session).permit(:title, :date, :kind_id, :gist, :description, :cover, {images: []})
  end
end