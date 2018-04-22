require 'rails_helper'

describe ContactMeController do
  describe 'POST create' do
    context 'with valid inputs' do
      before do
        post :create, params: { contact_me: { name: 'alice', email: 'alice@example.com', message: 'Tell me something.' } }
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it 'sends an email' do
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it 'sends an email with the submitted email in the body' do
        expect(ActionMailer::Base.deliveries.last.body).to match 'alice@example.com'
      end

      it 'sends an email with the submitted message in the body' do
        expect(ActionMailer::Base.deliveries.last.body).to match 'Tell me something.'
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the about path' do
        expect(response).to redirect_to about_path
      end
    end

    context 'with invalid inputs' do
      before do
        post :create, params: { contact_me: { name: 'alice', email: 'alice@example.com', message: '' } }
      end

      it 'sets the flash danger message' do
        expect(flash[:danger]).to be_present
      end

      it 'redirects to the about path' do
        expect(response).to render_template 'pages/about'
      end
    end
  end
end
