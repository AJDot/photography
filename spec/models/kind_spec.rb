require 'rails_helper'

describe Kind do
  it { is_expected.to have_many(:events) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:gist) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:price_description) }
  it { is_expected.to validate_presence_of(:banner) }
  it { is_expected.to validate_presence_of(:cover) }
end
