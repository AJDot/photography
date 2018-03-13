class Kind < ActiveRecord::Base
  has_many :sessions
  validates_presence_of :name, :price, :price_description, :gist, :description, :banner, :cover_image
end
