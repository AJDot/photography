class PrintsController < ApplicationController
  def index
    @shop = Etsy::Shop.find(shop_name: ENV['ETSY_SHOP_NAME'], includes: ['Listings:active/Images'])
  end
end
