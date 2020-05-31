class Tweet < ApplicationRecord
  THUMBNAIL_SIZE = [100, 100]
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :replies, dependent: :destroy
  validates :body, presence: true
end
