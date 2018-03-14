class SessionImagesController < ApplicationController
  before_action :set_session

  def create
    add_more_images(images_params[:images])
    if @session.save
      flash[:success] = "Upload successful. #{images_params[:images].count} added."
    else
      flash[:danger] = "Failed uploading images"
    end
    redirect_to session_path(@session)
  end

  def destroy
    removed = remove_image_at_index(params[:id].to_i)
    if removed && @session.save
      flash[:success] = "Delete successful."
    else
      flash[:danger] = "Failed deleting image"
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

  def remove_image_at_index(index)
    remain_images = @session.images
    deleted_image = remain_images.delete_at(index)
    return false if deleted_image.nil?

    deleted_image.try(:remove!) # delete image from S3
    @session.images = remain_images
    if @session.images.empty? && @session.read_attribute(:images).size > 0
      @session.write_attribute(:images, [])
    end

    true
  end

  def images_params
    params["session"] = {"images" => []} unless params[:session]
      params.require(:session).permit({ images: [] })
  end
end
