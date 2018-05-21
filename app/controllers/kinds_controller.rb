class KindsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :require_admin, except: [:index]

  def index
    @kinds = Kind.all
  end

  def new
    @kind = Kind.new
  end

  def create
    @kind = Kind.new(kind_params)
    if @kind.save
      flash[:success] = 'You have created a kind.'
      redirect_to root_path
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :new
    end
  end

  def edit
    @kind = Kind.find params[:id]
  end

  def update
    @kind = Kind.find params[:id]
    if @kind.update(kind_params)
      flash[:success] = 'You have updated this kind.'
      redirect_to root_path
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :edit
    end
  end

  def destroy
    kind = Kind.find params[:id]
    kind.destroy
    flash[:success] = "The event \"#{kind.name}\" was removed."
    redirect_to kinds_path
  end

  private

  def kind_params
    params.require(:kind).permit(:name, :gist, :description, :banner, :cover, :price, :price_description)
  end

  def record_not_found
    flash[:danger] = "A kind with id #{params[:id]} does not exist!"
    redirect_to kinds_path
  end
end
