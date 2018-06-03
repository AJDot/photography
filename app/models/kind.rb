class Kind < ActiveRecord::Base
  has_many :events, dependent: :destroy
  mount_uploader :cover, KindCoverUploader
  mount_uploader :banner, KindBannerUploader
  validates_presence_of :name, :price, :price_description, :gist, :description, :banner, :cover
  validates_presence_of :banner, on: :create
  validates_presence_of :cover, on: :create
end
