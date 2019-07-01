class Task < ApplicationRecord
  belongs_to :step
  attr_accessor :board_id
end
