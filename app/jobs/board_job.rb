class BoardJob < ApplicationJob
  queue_as :default

  def perform(board)
    ActionCable.server.broadcast 'board_channel', content: render_board(board), slug: board.slug, count_of_boards: render_count_of_boards, action: 'add-board'
  end

  private
    def render_board(board)
      ApplicationController.renderer.render(partial: 'boards/board_card', locals: { board: board })
    end

    def render_count_of_boards
      ApplicationController.renderer.render(partial: 'boards/count_of_boards', locals: { count_of_boards: Board.count })
    end
end
