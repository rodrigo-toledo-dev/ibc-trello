class StepsController < ApplicationController
  def update
    @step = Step.friendly.find(params[:id])
    if @step.update_attributes(step_params)
      flash[:success] = 'Etapa atualizada com sucesso'
    else
      flash[:error] = "Erro ao atualizar esta Etapa, verifique os alertas: #{@step.errors.full_messages.to_sentence}"
    end
    redirect_to board_path(@step.board)
  end

  def destroy
    @step = Step.friendly.find(params[:id])
    if @step.destroy
      flash[:success] = 'Etapa removida com sucesso'
    else
      flash[:error] = "Erro ao remover esta Etapa"
    end
    redirect_to board_path(@step.board)
  end

  protected

  def step_params
    params.require(:step).permit(:name)
  end

end
