class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :step
  has_one :board, through: :step
  has_many :steps, through: :board
  attr_accessor :board_id

  validates :name, presence: true
  validates :board_id, presence: true, on: :create

  before_validation :try_find_step, on: :create

  def can_move_left?
    self.step != self.steps.first
  end

  def can_move_right?
    self.step != self.steps.last
  end

  def move_to_the_left
    step_ids = self.step_ids
    next_step_id = step_ids[step_ids.find_index(self.step_id) - 1]
    self.update_attribute(:step_id, next_step_id)
    self.touch
  end

  def move_to_the_right
    step_ids = self.step_ids
    next_step_id = step_ids[step_ids.find_index(self.step_id) + 1]
    self.update_attribute(:step_id, next_step_id)
    self.touch
  end

  def try_find_step
    unless Step.where(board_id: self.board_id).exists?
      step = Step.create(board_id: self.board_id, name: 'To-Do')
      self.step_id = step.id
    else
      self.step_id = Step.find_by(board_id: self.board_id).id
    end
    true
  end
end