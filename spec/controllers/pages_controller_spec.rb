require 'rails_helper'

describe PagesController do
  describe 'GET about' do
    before { get :about }
    it 'sets @user to current user'
    it 'sets @contact_me for contact me form' do
      expect(assigns(:contact_me)).to be_instance_of ContactMe
    end
  end
end
