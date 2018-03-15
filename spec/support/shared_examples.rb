shared_examples 'session not found' do
  before do
    action
  end

  it 'redirects to sessions index page' do
    expect(response).to redirect_to sessions_path
  end

  it 'sets the flash danger message' do
    expect(flash[:danger]).to be_present
  end
end

shared_examples 'kind not found' do
  before do
    action
  end

  it 'redirects to sessions index page' do
    expect(response).to redirect_to kinds_path
  end

  it 'sets the flash danger message' do
    expect(flash[:danger]).to be_present
  end
end
