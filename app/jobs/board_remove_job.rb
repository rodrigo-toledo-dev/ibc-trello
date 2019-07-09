class BoardRemoveJob < ApplicationJob
  queue_as :default

  def perform(board)
    ActionCable.server.broadcast 'board_channel', slug: board.slug, count_of_boards: render_count_of_boards, action: 'remove-board'
  end

  private

    def render_count_of_boards
      ApplicationController.renderer.render(partial: 'boards/count_of_boards', locals: { count_of_boards: Board.count })
    end
end
