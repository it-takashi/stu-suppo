class Tweet < ApplicationRecord
  THUMBNAIL_SIZE = [100, 100]
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :comment, presence: true
end
