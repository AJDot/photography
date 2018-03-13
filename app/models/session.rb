class Session < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  belongs_to :kind
  mount_uploaders :images, SessionImageUploader
  mount_uploader :cover, SessionCoverUploader
  validates_presence_of :creator, :kind, :title, :date, :gist, :description, :cover
end
