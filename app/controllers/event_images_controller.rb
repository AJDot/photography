class EventImagesController < ApplicationController
  before_action :require_admin
  before_action :set_event

  def create
    add_more_images(images_params[:images])
    if @event.save
      flash[:success] = "Upload successful. #{images_params[:images].count} added."
    else
      flash[:danger] = "Failed uploading images"
    end
    redirect_to event_path(@event)
  end

  def destroy
    removed = remove_image_at_index(params[:id].to_i)
    if removed && @event.save
      flash[:success] = "Delete successful."
    else
      flash[:danger] = "Failed deleting image"
    end
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def add_more_images(new_images)
    @event.images += new_images if new_images
  end

  def remove_image_at_index(index)
    remain_images = @event.images
    deleted_image = remain_images.delete_at(index)
    return false if deleted_image.nil?

    deleted_image.try(:remove!) # delete image from S3
    @event.images = remain_images
    if @event.images.empty? && @event.read_attribute(:images).size > 0
      @event.write_attribute(:images, [])
    end

    true
  end

  def images_params
    params["event"] = {"images" => []} unless params[:event]
      params.require(:event).permit({images: [] })
  end
end
