class Task < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :step
  has_one :board, through: :step
  attr_accessor :board_id

  validates :name, presence: true
  validates :board_id, presence: true, on: :create

  before_validation :try_find_step, on: :create

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
