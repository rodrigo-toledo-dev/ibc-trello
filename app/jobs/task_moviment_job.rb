class TaskMovimentJob < ApplicationJob
  queue_as :default

  def perform(task, action_step)
    ActionCable.server.broadcast 'task_channel', action: 'moviment', content: render_task(task), slug: task.slug, current_step_slug: task.step.slug, action_step_slug: action_step.slug
  end

  private
    def render_task(task)
      ApplicationController.renderer.render(partial: 'tasks/form', locals: { task: task })
    end
end
