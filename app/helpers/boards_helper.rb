module BoardsHelper
  def board_front_image_url(board, resize = "500x325")
    board.front_image.attached? ? board.front_image.variant(resize: resize) : "http://placehold.it/#{resize}"
  end

  def board_card_image(board)
    image = image_tag(board_front_image_url(board), alt: board.name, class: 'card-img-top')
    if Rails.env.development?
      image.gsub!('http://example.org','http://localhost:3000')
    elsif Rails.env.production?
      image.gsub!('http://example.org','http://ibc-trello.herokuapp.com')
    end
    raw(image)
  end
end
