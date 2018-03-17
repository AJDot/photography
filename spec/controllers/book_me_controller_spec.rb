require 'rails_helper'

describe BookMeController do
  describe 'GET new' do
    it 'sets @book_me to a book_me' do
      get :new
      expect(assigns(:book_me)).to be_instance_of BookMe
    end
  end

  describe 'POST create' do
    context 'with valid inputs' do
      before do
        post :create, params: { book_me: { name: 'alice', phone: '1234567890', email: 'alice@example.com', event_date: '2018-12-31', event_type: 'Family', message: 'Tell me something.' } }
      end

      it 'sends a book_me email' do
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it 'sends a book_me email with the submitted email in the body' do
        expect(ActionMailer::Base.deliveries.last.body).to match 'alice@example.com'
      end

      it 'sends a book_me email with the submitted message in the body' do
        expect(ActionMailer::Base.deliveries.last.body).to match 'Tell me something.'
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the book_me path' do
        expect(response).to redirect_to book_me_path
      end
    end

    context 'with invalid inputs' do
      before do
        post :create, params: { book_me: { name: 'alice', phone: '1234567890', email: 'alice@example.com', event_date: '2018-12-31', event_type: 'Family', message: '' } }
      end

      it 'sets the flash danger message' do
        expect(flash[:danger]).to be_present
      end

      it 'redirects to the book_me path' do
        expect(response).to redirect_to book_me_path
      end
    end
  end
end
