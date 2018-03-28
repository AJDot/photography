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
    it_behaves_like 'requires admin' do
      let(:action) { get :new }
    end

    before do
      set_current_user
    end

    it 'sets @kind to a new kind' do
      get :new
      expect(assigns(:kind)).to be_a_new Kind
    end
  end

  describe 'POST create' do
    it_behaves_like 'requires admin' do
      let(:action) do
        post :create, params: { kind: Fabricate.attributes_for(:kind) }
      end
    end

    context 'with valid inputs' do
      let(:alice) { Fabricate(:user) }

      before do
        set_current_user(alice)
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
      let(:alice) { Fabricate(:user) }

      before do
        set_current_user(alice)
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
    let(:kind) { Fabricate(:kind) }

    it_behaves_like 'requires admin' do
      let(:action) { get :edit, params: { id: kind.id } }
    end

    before do
      set_current_user
    end

    it 'sets @kind to selected kind' do
      get :edit, params: { id: kind.id }
      expect(assigns(:kind)).to eq(kind)
    end

    it_behaves_like 'kind not found' do
      let(:action) { get :edit, params: { id: 1 } }
    end
  end

  describe 'PATCH update' do
    it_behaves_like 'requires admin' do
      kind = Fabricate(:kind, name: 'old name')
      attrs = kind.attributes.merge("name" => 'new name')
      let(:action) { patch :update, params: { kind: attrs, id: kind.id } }
    end

    before do
      set_current_user
    end

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

    it_behaves_like 'kind not found' do
      let(:action) { patch :update, params: { id: 1 } }
    end
  end

  describe 'DELETE destroy' do
    let(:alice) { Fabricate(:user) }
    let(:kind) { Fabricate(:kind) }
    let(:sess) { Fabricate(:event, title: 'old title', creator: alice, kind: kind) }

    before do
      set_current_user(alice)
    end

    context 'with an existing kind' do
      before do
        delete :destroy, params: { id: kind.id }
      end

      it 'deletes the kind' do
        expect(Kind.count).to eq(0)
      end

      it 'deletes associated events' do
        expect(Event.count).to eq(0)
      end

      it 'redirects to the kinds index page' do
        expect(response).to redirect_to kinds_path
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end
    end

    it_behaves_like 'kind not found' do
      let(:action) { delete :destroy, params: { id: 1 } }
    end
  end
end
