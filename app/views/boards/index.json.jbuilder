json.boards @boards do |board|
  json.id board.id
  json.name board.name
  json.slug board.slug
  json.front_image board_front_image_filename(board)
  json.created_at I18n.l(board.created_at, format: :short)
  json.updated_at I18n.l(board.updated_at, format: :short)
end
json.board @board
