class SessionImagesController < ApplicationController
  before_action :set_session

  def create
    add_more_images(images_params[:images])
    if @session.save
      flash[:success] = "Upload successful. #{images_params[:images].count} added."
    else
      flash[:danger] = "Failed uploading images" unless @session.save
    end
    redirect_to session_path(@session)
  end

  private

  def set_session
    @session = Session.find(params[:session_id])
  end

  def add_more_images(new_images)
    @session.images += new_images if new_images
  end

  def images_params
    params["session"] = {"images" => []} unless params[:session]
      params.require(:session).permit({ images: [] })
  end
end
