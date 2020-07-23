class Reply < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :tweet
  belongs_to :user

  validates :comment, presence: true, unless: :image?
end
