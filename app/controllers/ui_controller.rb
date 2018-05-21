class UiController < ApplicationController
  before_action do
    redirect_to :root if Rails.env.production? || Rails.env.staging?
  end

  layout "ui"

  def index
  end
end
