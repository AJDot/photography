class PrintsController < ApplicationController
  def index
    @shop = Etsy::Shop.find(shop_name: ENV['ETSY_SHOP_NAME'], includes: ['Listings:active:100:0/Images:1:0'])
  end
end
