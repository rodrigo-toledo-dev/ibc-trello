class BoardsController < ApplicationController
  def index
    @q = Board.order('created_at desc').ransack(params[:q])
    @boards = @q.result(distinct: true)
    @board = params[:id].blank? ? Board.new : Board.friendly.find(params[:id])
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:success] = 'Quadro criado com sucesso'
    else
      flash[:error] = "Erro ao criar este Quadro, verifique os alertas: #{@board.errors.full_messages.to_sentence}"
    end
    redirect_to root_path
  end

  def update
    @board = Board.friendly.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:success] = 'Quadro atualizado com sucesso'
    else
      flash[:error] = "Erro ao atualizar este Quadro, verifique os alertas: #{@board.errors.full_messages.to_sentence}"
    end
    redirect_to root_path
  end

  def destroy
    @board = Board.friendly.find(params[:id])
    if @board.destroy
      flash[:success] = 'Quadro removido com sucesso'
    else
      flash[:error] = "Erro ao remover este Quadro"
    end
    redirect_to root_path
  end

  protected

  def board_params
    params.require(:board).permit(:name, :front_image)
  end

end
