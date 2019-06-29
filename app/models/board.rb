class Board < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one_attached :front_image
  validates :name, presence: true
end
