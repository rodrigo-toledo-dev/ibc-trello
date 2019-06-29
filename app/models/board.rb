class Board < ApplicationRecord
  has_one_attached :front_image
  validates :name, presence: true
end
