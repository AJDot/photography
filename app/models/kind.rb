class Kind < ActiveRecord::Base
  has_many :sessions
  mount_uploader :cover, KindCoverUploader
  mount_uploader :banner, KindBannerUploader
  validates_presence_of :name, :price, :price_description, :gist, :description, :banner, :cover
end
