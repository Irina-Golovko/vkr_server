class Image < ActiveRecord::Base
  mount_uploader :file, ImageUploader
  belongs_to :user
  belongs_to :document
end
