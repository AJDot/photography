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

  describe 'GET edit' do
    it 'sets @kind to selected kind' do
      kind = Fabricate(:kind)
      get :edit, params: { id: kind.id }
      expect(assigns(:kind)).to eq(kind)
    end
  end

  describe 'PATCH update' do
    context 'with valid inputs' do
      let(:kind) { Fabricate(:kind, name: 'old name') }

      before do
        attrs = kind.attributes.merge("name" => 'new name')
        attrs["banner"] = fixture_file_upload(attrs["banner"])
        attrs["cover"] = fixture_file_upload(attrs["cover"])
        patch :update, params: { kind: attrs, id: kind.id }
      end

      it 'updates kind' do
        expect(Kind.first.name).to eq('new name')
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirect to the root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid inputs' do
      let(:kind) { Fabricate(:kind, name: 'old name') }

      before do
        attrs = kind.attributes.merge("name" => '')
        attrs["banner"] = fixture_file_upload(attrs["banner"])
        attrs["cover"] = fixture_file_upload(attrs["cover"])
        patch :update, params: { kind: attrs, id: kind.id }
      end

      it 'does not update kind' do
        expect(Kind.first.name).to eq('old name')
      end

      it 'sets flash danger message' do
        expect(flash[:danger]).to be_present
      end

      it 'renders the new template' do
        expect(response).to render_template :edit
      end
    end
  end
end
