class Tweet < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :replies, dependent: :destroy
end
