class Board < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one_attached :front_image
  validates :name, presence: true
  has_many :steps, dependent: :destroy
  has_many :tasks, through: :steps, dependent: :destroy

  after_create_commit :insert_in_real_time

  def insert_in_real_time
    BoardJob.perform_later(self)
  end

end
