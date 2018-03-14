class KindsController < ApplicationController
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

  private

  def kind_params
    params.require(:kind).permit(:name, :gist, :description, :banner, :cover, :price, :price_description)
  end
end
