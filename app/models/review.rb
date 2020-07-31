class Review < ApplicationRecord

  belongs_to :user
  belongs_to :callroom

  validates :rate, presence: true
end