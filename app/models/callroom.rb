class Callroom < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :student_id, uniqueness: true
end
