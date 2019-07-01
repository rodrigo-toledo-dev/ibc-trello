class Step < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :board

  validates :name, presence: true
end
