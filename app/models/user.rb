class User < ActiveRecord::Base
  mount_uploader :portrait, UserPortraitUploader
end
