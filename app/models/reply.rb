class Reply < ApplicationRecord
  THUMBNAIL_SIZE = [100, 100]
  mount_uploader :image, ImageUploader

  belongs_to :tweet
  belongs_to :user

  validates :comment, presence: true, unless: :image?
end
