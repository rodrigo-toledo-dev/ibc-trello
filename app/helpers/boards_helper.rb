module BoardsHelper
  def board_front_image(board)
    board.front_image.blank? ? 'http://placehold.it/500x325' : board.front_image.variant(resize: "500x325").processed.service_url
  end
end
