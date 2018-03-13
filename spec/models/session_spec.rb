require 'rails_helper'

describe Session do
  it { is_expected.to belong_to(:creator) }
  it { is_expected.to validate_presence_of(:creator) }
  pending { is_expected.to validate_presence_of(:kind) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:gist) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:cover_image) }
end