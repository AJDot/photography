require 'rails_helper'

describe SessionsController do
  describe 'GET new' do
    it 'sets @session to a new session' do
      get :new
      expect(assigns(:session)).to be_a_new Session
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
      let(:current_user) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }

      before do
        session[:user_id] = current_user.id
        post :create, params: { session: Fabricate.attributes_for(:session).merge({"kind_id" => kind.id}) }
      end

      it 'creates a session' do
        expect(Session.count).to eq(1)
      end

      it 'set flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid inputs' do
      let(:current_user) { Fabricate(:user) }

      before do
        session[:user_id] = current_user.id
        altered_params = Fabricate.attributes_for(:session).merge({'title' => ''})
        post :create, params: { session: altered_params }
      end

      it 'does not create a new session' do
        expect(Session.count).to eq(0)
      end

      it 'sets flash danger message' do
        expect(flash[:danger]).to be_present
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end
  end
end
