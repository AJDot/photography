class Kind < ActiveRecord::Base
  has_many :sessions
  validates_presence_of :price, :price_description, :gist, :description, :banner, :cover_image
end
