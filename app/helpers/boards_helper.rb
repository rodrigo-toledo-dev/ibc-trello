module BoardsHelper
  def board_front_image_url(board)
    board.front_image.attached? ? board.front_image.variant(resize: "500x325") : 'http://placehold.it/500x325'
  end
end
