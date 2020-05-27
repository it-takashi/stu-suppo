class Teach < ApplicationRecord
  THUMBNAIL_SIZE = [100, 100]
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :messages, dependent: :destroy
end
