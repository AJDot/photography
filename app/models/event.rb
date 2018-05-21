class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  belongs_to :kind
  mount_uploaders :images, EventImageUploader
  mount_uploader :cover, EventCoverUploader
  validates_presence_of :creator, :kind, :title, :date, :gist, :description, :cover
  validate :images_cant_be_blank

  def images_cant_be_blank
    errors.add(:event_images, 'one or more files were blank') if images.any?(&:blank?)
  end

  def as_json(options = {})
    options[:except] = [:kind, :kind_id]
    attrs = super(options)
    attrs["kind"] = kind.as_json
    attrs
  end
end
