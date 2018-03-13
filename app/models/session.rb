class Session < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  validates_presence_of :creator, :title, :date, :gist, :description, :cover_image
  # validates_presence_of :kind
end
