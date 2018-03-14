class PagesController < ApplicationController
  def home
    @kinds = Kind.all
    render 'kinds/index'
  end

  def index
  end
end
