class Session < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  belongs_to :kind
  validates_presence_of :creator, :kind, :title, :date, :gist, :description, :cover_image
end
