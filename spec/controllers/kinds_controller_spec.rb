require 'rails_helper'

describe KindsController do
  describe 'GET index' do
    it 'sets @kinds to all kinds' do
      Fabricate.times(3, :kind)
      get :index
      expect(assigns(:kinds).count).to eq(3)
    end
  end

  describe 'GET new' do
    it 'sets @kind to a new kind' do
      get :new
      expect(assigns(:kind)).to be_a_new Kind
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
      let(:current_user) { Fabricate(:user) }

      before do
        session[:user_id] = current_user.id
        post :create, params: { kind: Fabricate.attributes_for(:kind) }
      end

      it 'creates a kind' do
        expect(Kind.count).to eq(1)
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirect to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid inputs' do
      let(:current_user) { Fabricate(:user) }

      before do
        session[:user_id] = current_user.id
        post :create, params: { kind: Fabricate.attributes_for(:kind, name: '') }
      end

      it 'does not create a new kind' do
        expect(Kind.count).to eq(0)
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
