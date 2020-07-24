class Message < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :callroom
  belongs_to :user
  
  validates :comment, presence: true, unless: :image?
end
