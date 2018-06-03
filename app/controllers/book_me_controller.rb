class BookMeController < ApplicationController
  def new
    @book_me = BookMe.new
  end

  def create
    @book_me = BookMe.new(book_me_params)
    if @book_me.valid?
      AppMailer.book_me(@book_me).deliver
      flash[:success] = 'Message sent!'
      redirect_to book_me_path
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      render :new
    end
  end

  private

  def book_me_params
    params.require(:book_me).permit(:name, :phone, :email, :event_date, :event_type, :message)
  end
end
