require 'rails_helper'

describe SessionImagesController do
  describe 'POST create' do
    let(:alice) { Fabricate(:user) }
    let(:kind) { Fabricate(:kind) }
    let(:sess) { Fabricate(
      :session,
      creator: alice,
      kind: kind,
      images: [fixture_file_upload(Rails.root.join('spec/fixtures/new_session.jpg'))]
    )}

    context 'with at least 1 file ready to upload' do
      before do
        post :create, params: { session: { images: [fixture_file_upload(Rails.root.join('spec/fixtures/new_session.jpg'))] }, session_id: sess.id }
      end

      it 'adds images to session' do
        expect(Session.first.images.count).to eq(2)
      end

      it 'sets the flash success message if upload succeeds' do
        expect(flash[:success]).to be_present
      end


      it 'redirects to session path' do
        expect(response).to redirect_to session_path(sess)
      end
    end

    context 'without any files submitted to upload' do
      it 'redirects to session page if no files were uploaded by user' do
        post :create, params: { session_id: sess.id }
        expect(response).to redirect_to session_path(sess)
      end
    end

    context 'with files unable to save' do
      before do
        post :create, params: { session: { images: ['not an image'] }, session_id: sess.id }
      end

      it 'sets the flash danger message if upload fails' do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with more than 1 image present, deleting 1' do
      let(:alice) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }
      let(:sess) { Fabricate(
        :session,
        creator: alice,
        kind: kind,
        images: [
          fixture_file_upload(Rails.root.join('spec/fixtures/new_session.jpg')),
          fixture_file_upload(Rails.root.join('spec/fixtures/new_kind.jpg'))
        ]
      )}

      before do
        delete :destroy, params: { session_id: sess.id, id: 0 }
      end

      it 'removes the image from the session' do
        expect(Session.first.images.count).to eq(1)
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the session page' do
        expect(response).to redirect_to session_path(sess)
      end
    end

    context 'with 1 image present, deleting 1' do
      let(:alice) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }
      let(:sess) { Fabricate(
        :session,
        creator: alice,
        kind: kind,
        images: [
          fixture_file_upload(Rails.root.join('spec/fixtures/new_session.jpg'))
        ]
      )}

      before do
        delete :destroy, params: { session_id: sess.id, id: 0 }
      end

      it 'removes the image from the session' do
        expect(Session.first.images.count).to eq(0)
      end

      it 'sets the flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the session page' do
        expect(response).to redirect_to session_path(sess)
      end
    end

    context 'for unsuccessful deletion' do
      let(:alice) { Fabricate(:user) }
      let(:kind) { Fabricate(:kind) }
      let(:sess) { Fabricate(
        :session,
        creator: alice,
        kind: kind,
        images: [
          fixture_file_upload(Rails.root.join('spec/fixtures/new_session.jpg'))
        ]
      )}

      before do
        delete :destroy, params: { session_id: sess.id, id: 1 }
      end

      it 'sets the flash danger message' do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
