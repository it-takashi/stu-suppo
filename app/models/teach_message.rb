class TeachMessage < ApplicationRecord
  mount_uploader :image, ImageUploader
  THUMBNAIL_SIZE = [100, 100]

  belongs_to :user
  belongs_to :teach
end
