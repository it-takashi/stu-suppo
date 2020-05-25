class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true
  THUMBNAIL_SIZE = [100, 100]
  mount_uploader :image, ImageUploader
  has_many :tweets
end
