module BoardsHelper
  def board_front_image_url(board, resize = "500x325")
    board.front_image.attached? ? board.front_image.variant(resize: resize) : "http://placehold.it/#{resize}"
  end
end
