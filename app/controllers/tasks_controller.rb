class TasksController < ApplicationController

  def create
    task = Task.new(task_params)
    if task.save
      flash[:success] = 'Tarefa criada com sucesso'
    else
      flash[:error] = "Erro ao criar esta Tarefa, verifique os alertas: #{task.errors.full_messages.to_sentence}"
    end
    redirect_to board_path(task.board)
  end

  def update
    @task = Task.friendly.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = 'Tarefa atualizada com sucesso'
    else
      flash[:error] = "Erro ao atualizar esta Tarefa, verifique os alertas: #{@task.errors.full_messages.to_sentence}"
    end
    redirect_to board_path(@task.board)
  end

  def move_left
    @task = Task.friendly.find(params[:id])
    if @task.can_move_left?
      @task.move_to_the_left
      flash[:success] = 'Tarefa atualizada com sucesso'
    end
    redirect_to board_path(@task.step.board)
  end

  def move_right
    @task = Task.friendly.find(params[:id])
    if @task.can_move_right?
      @task.move_to_the_right
      flash[:success] = 'Tarefa atualizada com sucesso'
    end
    redirect_to board_path(@task.step.board)
  end

  def destroy
    @task = Task.friendly.find(params[:id])
    if @task.destroy
      flash[:success] = 'Tarefa removida com sucesso'
    else
      flash[:error] = "Erro ao remover esta Tarefa"
    end
    redirect_to board_path(@task.board)
  end

  protected

  def task_params
    params.require(:task).permit(:name, :board_id)
  end

end
