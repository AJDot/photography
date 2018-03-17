class PagesController < ApplicationController
  def root
    redirect_to home_path
  end

  def home
    @kinds = Kind.all
    render 'kinds/index'
  end

  def index
    redirect_to root_path if Rails.env.production?
  end

  def about
    @user = User.first
    @contact_me = ContactMe.new
  end
end
