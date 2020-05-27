class Message < ApplicationRecord
  belongs_to :teach
  belongs_to :user

  validates :comment, presence: true, unless: :image?
end
