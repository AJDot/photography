require 'rails_helper'

describe UsersController do
  describe 'GET edit' do
    it 'sets @user to current logged in user'
  end

  describe 'PATCH update' do
    context 'with valid inputs' do
      let(:current_user) { Fabricate(:user, name: 'old name') }

      before do
        event[:user_id] = current_user.id
        altered_params = current_user.attributes.merge({'name' => 'new name'})
        patch :update, params: { user: altered_params, id: current_user.id }
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
      let(:current_user) { Fabricate(:user, name: 'old name') }

      before do
        event[:user_id] = current_user.id
        altered_params = current_user.attributes.merge({'name' => ''})
        patch :update, params: { user: altered_params, id: current_user.id }
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
