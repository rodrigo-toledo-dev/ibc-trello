class Task < ApplicationRecord
  belongs_to :step
  has_many :tasks, dependent: :destroy
  attr_accessor :board_id
end
