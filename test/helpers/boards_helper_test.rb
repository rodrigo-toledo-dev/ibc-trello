class BoardsHelperTest < ActionView::TestCase
  setup do
    @board = boards(:board)
    @board.save
    @board_with_image = boards(:board_with_image)
    @board_with_image.front_image = fixture_file_upload(Rails.root.join('test', 'support', 'assets', 'test-image.png'), 'image/png')
    @board_with_image.save
  end

  test 'should return the placehold image' do
    assert_dom_equal %{<img alt="#{@board.name}" class="card-img-top" src="http://placehold.it/500x325" />}, board_card_image(@board)
  end
end
