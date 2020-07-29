class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { maximum: 10,  message:"は10文字以下で登録してください" }
  THUMBNAIL_SIZE = [100, 100]
  mount_uploader :image, ImageUploader
  has_many :tweets
  has_many :messages
  has_many :replies
  has_one :callroom
  has_many :reviews

  # ゲストユーザー
  def self.guest
    find_or_create_by!(name: "ゲストユーザー",email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end
end
