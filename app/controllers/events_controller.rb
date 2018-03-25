class EventsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @events = Event.all
    @kinds = Kind.select { |k| k.events.count > 0 }
    @filter = params[:kind] || ""
  end

  def show
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
  end

  def create
    @user = User.first
    @event = Event.new(event_params)
    @event.creator = @user
    if @event.save
      flash[:success] = 'You have created an event.'
      redirect_to event_path(@event)
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :new
    end
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    if @event.update(event_params)
      flash[:success] = 'You have updated this event.'
      redirect_to event_path(@event)
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :edit
    end
  end

  def destroy
    event = Event.find params[:id]
    event.destroy
    flash[:success] = "The event \"#{event.title}\" was removed."
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :date, :kind_id, :gist, :description, :cover, {event_images: []})
  end

  def record_not_found
    flash[:danger] = "A event with id #{params[:id]} does not exist!"
    redirect_to events_path
  end
end
