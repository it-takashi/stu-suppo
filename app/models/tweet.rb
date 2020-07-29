class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
