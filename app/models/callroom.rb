class Callroom < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :body, presence: true
  validates :student_id, presence:true, if: :published?
  
  def published?
    student_id = user_id
  end


  belongs_to :user
  # has_many :messages, dependent: :destroy
end
