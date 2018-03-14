class Session < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  belongs_to :kind
  mount_uploaders :images, SessionImageUploader
  mount_uploader :cover, SessionCoverUploader
  validates_presence_of :creator, :kind, :title, :date, :gist, :description, :cover
  validate :images_cant_be_blank

  def images_cant_be_blank
    errors.add(:images, 'one or more files were blank') if images.any?(&:blank?)
  end
end
