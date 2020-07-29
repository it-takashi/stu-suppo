class Review < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  belongs_to :callroom

  validates :rate, presence: true
end