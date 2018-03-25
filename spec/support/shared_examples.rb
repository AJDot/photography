shared_examples 'event not found' do
  before do
    action
  end

  it 'redirects to events index page' do
    expect(response).to redirect_to events_path
  end

  it 'sets the flash danger message' do
    expect(flash[:danger]).to be_present
  end
end

shared_examples 'kind not found' do
  before do
    action
  end

  it 'redirects to events index page' do
    expect(response).to redirect_to kinds_path
  end

  it 'sets the flash danger message' do
    expect(flash[:danger]).to be_present
  end
end

shared_examples 'requires admin' do
  it 'redirects to home page' do
    clear_current_user
    action
    expect(response).to redirect_to home_path
  end
end
