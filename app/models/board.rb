class Board < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_one_attached :front_image
  validates :name, presence: true
  has_many :steps, dependent: :destroy
  has_many :tasks, through: :steps, dependent: :destroy

  after_create_commit :insert_in_real_time
  before_destroy :remove_in_real_time

  protected
    def insert_in_real_time
      logger.info "======================================"
      logger.info "Insert Board in Real TIME #{self.inspect}"
      logger.info "======================================"
      BoardJob.perform_later(self)
    end

    def remove_in_real_time
      logger.info "======================================"
      logger.info "Remove Board in Real TIME #{self.inspect}"
      logger.info "======================================"
      BoardRemoveJob.perform_later(self)
    end

end
