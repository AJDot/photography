require 'rails_helper'

describe EventsController do

  describe 'GET index' do
    before do
      Fabricate.times(3, :kind)
      Fabricate.times(3, :event, creator: Fabricate(:user), kind: Kind.first)
      get :index
    end

    it 'sets @events to a all events' do
      expect(assigns(:events).count).to eq(3)
    end

    it 'sets @kinds to an array of kind objects' do
      expect(assigns(:kinds).class).to eq(Array)
      expect(assigns(:kinds).first).to be_instance_of Kind
    end

    it 'sets @kinds to an array of kind objects that have at least 1 event' do
      expect(assigns(:kinds).count).to eq(1)
    end
  end

  describe 'GET show' do
    it 'sets @event to selected event' do
      sess = Fabricate(:event, creator: Fabricate(:user), kind: Fabricate(:kind))
      get :show, params: { id: sess.id }
      expect(assigns(:event)).to eq(sess)
    end
  end

  describe 'GET new' do
    it 'sets @event to a new event' do
      get :new
      expect(assigns(:event)).to be_a_new Event
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
      let(:current_user) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }

      before do
        event[:user_id] = current_user.id
        post :create, params: {event: Fabricate.attributes_for(:event).merge({"kind_id" => kind.id}) }
      end

      it 'creates a event' do
        expect(Event.count).to eq(1)
      end

      it 'set flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the event page' do
        expect(response).to redirect_to event_path(Event.first)
      end
    end

    context 'with invalid inputs' do
      let(:current_user) { Fabricate(:user) }

      before do
        event[:user_id] = current_user.id
        altered_params = Fabricate.attributes_for(:event).merge({'title' => ''})
        post :create, params: {event: altered_params }
      end

      it 'does not create a new event' do
        expect(Event.count).to eq(0)
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
    it 'sets @event to selected event' do
      alice = Fabricate(:user)
      kind = Fabricate(:kind)
      sess = Fabricate(:event, creator: alice, kind: kind)

      get :edit, params: { id: sess.id }
      expect(assigns(:event)).to eq(sess)
    end

    it_behaves_like 'event not found' do
      let(:action) { get :edit, params: { id: 1 } }
    end
  end

  describe 'PATCH update' do
    context 'with valid inputs' do
      let(:alice) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }
      let(:sess) { Fabricate(:event, title: 'old title', creator: alice, kind: kind) }

      before do
        attrs = sess.attributes.merge("title" => 'new title')
        attrs["images"] = attrs["images"].map { |i| fixture_file_upload(i) }
        attrs["cover"] = fixture_file_upload(attrs["cover"])
        patch :update, params: { event: attrs, id: sess.id }
      end

      it 'updates event' do
        expect(Event.first.title).to eq('new title')
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirect to the event page' do
        expect(response).to redirect_to event_path(sess)
      end
    end

    context 'with invalid inputs' do
      let(:alice) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }
      let(:sess) { Fabricate(:event, title: 'old title', creator: alice, kind: kind) }

      before do
        attrs = sess.attributes.merge("title" => '')
        attrs["images"] = attrs["images"].map { |i| fixture_file_upload(i) }
        attrs["cover"] = fixture_file_upload(attrs["cover"])
        patch :update, params: { event: attrs, id: sess.id }
      end

      it 'does not update event' do
        expect(Event.first.title).to eq('old title')
      end

      it 'sets flash danger message' do
        expect(flash[:danger]).to be_present
      end

      it 'renders the new template' do
        expect(response).to render_template :edit
      end
    end

    it_behaves_like 'event not found' do
      let(:action) { patch :update, params: { id: 1 } }
    end
  end

  describe 'DELETE destroy' do
    context 'with an existing event' do
      let(:alice) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }
      let(:sess) { Fabricate(:event, title: 'old title', creator: alice, kind: kind) }

      before do
        delete :destroy, params: { id: sess.id }
      end

      it 'deletes the event' do
        expect(Event.count).to eq(0)
      end

      it 'redirects to the events index page' do
        expect(response).to redirect_to events_path
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end
    end

    it_behaves_like 'event not found' do
      let(:action) { delete :destroy, params: { id: 1 } }
    end
  end
end
