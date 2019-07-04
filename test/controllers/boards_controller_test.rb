require 'test_helper'

class BoardsControllerTest < ActionController::TestCase
  setup do
    board = boards(:board)
    board.save
    board_with_image = boards(:board_with_image)
    board_with_image.front_image = fixture_file_upload(Rails.root.join('test', 'support', 'assets', 'test-image.png'), 'image/png')
    board_with_image.save
  end


  class IndexContext < BoardsControllerTest
    class FilterContext < IndexContext
      test 'without filter' do
        get :index
        assert_response :success
        assert_equal assigns(:boards).size, 2
        assert_equal Board.joins(:front_image_attachment).count, 1
      end

      test 'with filter' do
        get :index, params: {q: {name_cont: 'With Board'}}
        assert_response :success
      end

      class EditContext < FilterContext
        test 'when is a new record' do
          get :index
          assert_response :success
          assert assigns(:board).new_record?
        end

        test 'when edit a record' do
          get :index, params: {id: Board.first}
          assert_response :success
          assert_equal assigns(:board), Board.first
        end
      end
    end
  end

  class SaveContext < BoardsControllerTest
    class CreateContext < SaveContext
      test 'with error' do
        post :create, params: {board: {name: ''}}
        assert_equal flash[:error], 'Erro ao criar este Quadro, verifique os alertas: Nome do Quadro não pode ficar em branco'
        assert_redirected_to action: :index
      end

      test 'with success' do
        post :create, params: {board: {name: 'ToDo'}}
        assert_equal flash[:success], 'Quadro criado com sucesso'
        assert_redirected_to action: :index
      end
    end

    class UpdateContext < SaveContext
      test 'with error' do
        board = Board.first
        patch :update, params: {id: board, board: {name: ''}}
        assert_equal flash[:error], 'Erro ao atualizar este Quadro, verifique os alertas: Nome do Quadro não pode ficar em branco'
        assert_redirected_to action: :show, id: board
      end

      test 'with success' do
        board = Board.first
        patch :update, params: {id: board, board: {name: 'A fazer'}}
        assert_equal flash[:success], 'Quadro atualizado com sucesso'
        assert_redirected_to action: :show, id: board
      end
    end
  end

  class DestroyContext < BoardsControllerTest
    test 'with error' do
      Board.any_instance.stubs(:destroy).returns(false)
      delete :destroy, params: {id: Board.first}
      assert_equal flash[:error], 'Erro ao remover este Quadro'
      assert_redirected_to action: :index
      assert_equal Board.count, 2
    end

    test 'with success' do
      delete :destroy, params: {id: Board.first}
      assert_equal flash[:success], 'Quadro removido com sucesso'
      assert_redirected_to action: :index
      assert_equal Board.count, 1
    end
  end

  class ShowContext < BoardsControllerTest
    test 'show the board and build step and task' do
      board = Board.first
      get :show, params: {id: board}
      assert_equal assigns(:board), board
      assert_equal assigns(:new_step).board_id, board.id
      assert_equal assigns(:new_task).board_id, board.id
      assert_response :success
    end
  end
end
