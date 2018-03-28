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
      event = Fabricate(:event, creator: Fabricate(:user), kind: Fabricate(:kind))
      get :show, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'GET new' do
    it_behaves_like 'requires admin' do
      let(:action) { get :new }
    end

    before { set_current_user }

    it 'sets @event to a new event' do
      get :new
      expect(assigns(:event)).to be_a_new Event
    end
  end

  describe 'POST create' do
    it_behaves_like 'requires admin' do
      let(:action) { post :create }
    end

    before { set_current_user }

    context 'with valid inputs' do
      let(:alice) { Fabricate(:user, owner: true) }
      let(:kind) { Fabricate(:kind) }

      before do
        set_current_user(alice)
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
      before do
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
    let(:alice) { Fabricate(:user) }
    let(:kind) { Fabricate(:kind) }
    let(:event) { Fabricate(:event, creator: alice, kind: kind) }

    it_behaves_like 'requires admin' do
      let(:action) { get :edit, params: { id: event.id } }
    end

    before { set_current_user(alice) }

    it 'sets @event to selected event' do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it_behaves_like 'event not found' do
      let(:action) { get :edit, params: { id: 1 } }
    end
  end

  describe 'PATCH update' do
    let(:alice) { Fabricate(:user) }

    it_behaves_like 'requires admin' do
      alice = Fabricate(:user)
      kind = Fabricate(:kind)
      event = Fabricate(:event, title: 'old title', creator: alice, kind: kind)
      let(:action) { patch :update, params: { id: event.id } }
    end

    before { set_current_user(alice) }

    context 'with valid inputs' do
      let(:kind) { Fabricate(:kind) }
      let(:event) { Fabricate(:event, title: 'old title', creator: alice, kind: kind) }

      before do
        attrs = event.attributes.merge("title" => 'new title')
        attrs["images"] = attrs["images"].map { |i| fixture_file_upload(i) }
        attrs["cover"] = fixture_file_upload(attrs["cover"])
        patch :update, params: { event: attrs, id: event.id }
      end

      it 'updates event' do
        expect(Event.first.title).to eq('new title')
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirect to the event page' do
        expect(response).to redirect_to event_path(event)
      end
    end

    context 'with invalid inputs' do
      let(:kind) { Fabricate(:kind) }
      let(:event) { Fabricate(:event, title: 'old title', creator: alice, kind: kind) }

      before do
        attrs = event.attributes.merge("title" => '')
        attrs["images"] = attrs["images"].map { |i| fixture_file_upload(i) }
        attrs["cover"] = fixture_file_upload(attrs["cover"])
        patch :update, params: { event: attrs, id: event.id }
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
    let(:alice) { Fabricate(:user) }

    it_behaves_like 'requires admin' do
      event = Fabricate(:event, title: 'old title', creator: Fabricate(:user), kind: Fabricate(:kind))
      let(:action) { delete :destroy, params: { id: event.id } }
    end

    before { set_current_user }

    context 'with an existing event' do
      let(:kind) { Fabricate(:kind) }
      let(:event) { Fabricate(:event, title: 'old title', creator: alice, kind: kind) }

      before do
        delete :destroy, params: { id: event.id }
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
