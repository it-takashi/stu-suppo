class Teach < ApplicationRecord
  mount_uploader :image, ImageUploader
  THUMBNAIL_SIZE = [100, 100]

  belongs_to :user
  has_many :teach_messages, dependent: :destroy
end
