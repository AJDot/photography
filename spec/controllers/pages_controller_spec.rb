require 'rails_helper'

describe PagesController do
  describe 'GET about' do
    let(:alice) { Fabricate(:user, owner: true) }

    before do
      alice
      get :about
    end

    it 'sets @user to site owner' do
      expect(assigns(:user)).to eq(alice)
    end

    it 'sets @contact_me for contact me form' do
      expect(assigns(:contact_me)).to be_instance_of ContactMe
    end
  end
end
