class ContactMeController < ApplicationController
  def create
    @contact_me = ContactMe.new(contact_me_params)
    if @contact_me.valid?
      AppMailer.contact_me(@contact_me).deliver
      flash[:success] = 'Message sent!'
      redirect_to about_path
    else
      flash[:danger] = 'There was an problem processing the form. Please correct the errors below.'
      @user = User.find_by owner: true
      render 'pages/about'
    end
  end

  private

  def contact_me_params
    params.require(:contact_me).permit(:name, :email, :message)
  end
end
