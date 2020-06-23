class Callroom < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  validates :release, presence: true
  # has_many :messages, dependent: :destroy
end
