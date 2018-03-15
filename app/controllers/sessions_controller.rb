class SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @sessions = Session.all
    @kinds = Kind.select { |k| k.sessions.count > 0 }
    @filter = params[:kind] || ""
  end

  def show
    @session = Session.find params[:id]
  end

  def new
    @session = Session.new
  end

  def create
    @user = User.first
    @session = Session.new(session_params)
    @session.creator = @user
    binding.pry
    if @session.save
      flash[:success] = 'You have created a session.'
      redirect_to session_path(@session)
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :new
    end
  end

  def edit
    @session = Session.find params[:id]
  end

  def update
    @session = Session.find params[:id]
    if @session.update(session_params)
      flash[:success] = 'You have updated this session.'
      redirect_to session_path(@session)
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :edit
    end
  end

  def destroy
    sess = Session.find params[:id]
    sess.destroy
    flash[:success] = "The session \"#{sess.title}\" was removed."
    redirect_to sessions_path
  end

  private

  def session_params
    params.require(:session).permit(:title, :date, :kind_id, :gist, :description, :cover, {images: []})
  end

  def record_not_found
    flash[:danger] = "A session with id #{params[:id]} does not exist!"
    redirect_to sessions_path
  end
end
