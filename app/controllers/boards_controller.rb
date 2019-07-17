class BoardsController < ApplicationController
  def index
    @boards = @q.result(distinct: true)
    @board = params[:id].blank? ? Board.new : Board.friendly.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
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

  def show
    @board = Board.friendly.find(params[:id])
    @new_step = @board.steps.build
    @new_task = Task.new(board_id: @board.id)
  end

  def update
    @board = Board.friendly.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:success] = 'Quadro atualizado com sucesso'
    else
      flash[:error] = "Erro ao atualizar este Quadro, verifique os alertas: #{@board.errors.full_messages.to_sentence}"
    end
    redirect_to board_path(@board)
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
