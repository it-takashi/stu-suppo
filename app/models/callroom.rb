class Callroom < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
