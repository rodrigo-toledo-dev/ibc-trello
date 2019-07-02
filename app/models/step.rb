class Step < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  audited

  belongs_to :board
  has_many :tasks, dependent: :destroy

  validates :name, presence: true
end
