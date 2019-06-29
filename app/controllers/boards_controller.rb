class BoardsController < ApplicationController
  def index
    @boards = Board.order('created_at desc')
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:success] = 'Quadro criado com sucesso'
    else
      flash[:error] = "Erro ao criar este Quadro, verifique os alertas: #{@board.errors.full_messages.to_sentence}"
    end
    redirect_to boards_path
  end

  protected

  def board_params
    params.require(:board).permit(:name, :front_image)
  end

end
