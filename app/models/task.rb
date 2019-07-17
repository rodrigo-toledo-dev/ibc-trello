class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  audited

  belongs_to :step
  has_one :board, through: :step
  has_many :steps, through: :board
  attr_accessor :board_id

  validates :name, presence: true
  validates :board_id, presence: true, on: :create

  before_validation :try_find_step, on: :create

  def can_move_left?
    self.step != self.board.steps.first
  end

  def can_move_right?
    self.step != self.board.steps.last
  end

  def move_to_the_left
    self.update_attribute(:step_id, previous_step_id)

    # action_step = Step.find(previous_step_id)
    # logger.info "======================================"
    # logger.info "Moving to left || task: #{self.inspect} to #{action_step.inspect} in Real TIME"
    # logger.info "======================================"
    # TaskMovimentJob.perform_later(self, action_step)
  end

  def move_to_the_right
    self.update_attribute(:step_id, next_step_id)

    # action_step = Step.find(next_step_id)
    # logger.info "======================================"
    # logger.info "Moving to right || task: #{self.inspect} to #{action_step.inspect} in Real TIME"
    # logger.info "======================================"
    # TaskMovimentJob.perform_later(self, action_step)
  end

  def previous_step_id
    step_ids = self.board.step_ids
    step_ids[step_ids.find_index(self.step_id) - 1]
  end

  def next_step_id
    step_ids = self.board.step_ids
    step_ids[step_ids.find_index(self.step_id) + 1]
  end

  protected

  def try_find_step
    unless Step.where(board_id: self.board_id).exists?
      step = Step.create(board_id: self.board_id, name: 'To-Do')
      self.step_id = step.id
    else
      self.step_id = Board.find(self.board_id).steps.first.id
    end
    true
  end

  def moviment_in_real_time
    logger.info "======================================"
      logger.info "Insert Board in Real TIME #{self.inspect}"
      logger.info "======================================"
      BoardJob.perform_later(self)
  end
end
