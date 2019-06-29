class BoardsController < ApplicationController
  def index
    @boards = Board.order('created_at desc')
  end
end
