class User < ActiveRecord::Base
  has_many :events
  mount_uploader :portrait, UserPortraitUploader

  has_secure_password
  validates_presence_of :name, :email, :summary
  validates_presence_of :password, on: :create
end
