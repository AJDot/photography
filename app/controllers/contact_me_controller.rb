class ContactMeController < ApplicationController
  def create
    contact_me = ContactMe.new(contact_me_params)
    if contact_me.valid?
      AppMailer.contact_me(contact_me).deliver
      flash[:success] = 'Message sent!'
    else
      flash[:danger] = 'Something went wrong! Please try again later.'
    end
    redirect_to about_path
  end

  private

  def contact_me_params
    params.require(:contact_me).permit(:name, :email, :message)
  end
end
