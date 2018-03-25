require 'rails_helper'

describe UsersController do
  describe 'GET edit' do
    it_behaves_like 'requires admin' do
      let(:action) { get :edit, params: {id: 1 } }
    end

    let(:alice) { Fabricate(:user, name: 'old name') }

    it 'sets @user to current logged in user' do
      set_current_user(alice)
      get :edit, params: { id: alice.id }
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe 'PATCH update' do
    it_behaves_like 'requires admin' do
      let(:action) { patch :update, params: {id: 1 } }
    end

    context 'with valid inputs' do
      let(:alice) { Fabricate(:user, name: 'old name') }

      before do
        set_current_user(alice)
        altered_params = alice.attributes.merge({'name' => 'new name'})
        patch :update, params: { user: altered_params, id: alice.id }
      end

      it 'updates user' do
        expect(User.first.name).to eq('new name')
      end

      it 'set flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid inputs' do
      let(:alice) { Fabricate(:user, name: 'old name') }

      before do
        set_current_user(alice)
        altered_params = alice.attributes.merge({'name' => ''})
        patch :update, params: { user: altered_params, id: alice.id }
      end

      it 'does not update user' do
        expect(User.first.name).to eq('old name')
      end

      it 'sets flash danger message' do
        expect(flash[:danger]).to be_present
      end

      it 'renders the edit template' do
        expect(response).to render_template :edit
      end
    end
  end
end
