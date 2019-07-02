module TasksHelper
  def task_move_left(task)
    return unless task.can_move_left?
    link_to icon('fas', 'caret-square-left'), move_left_task_path(task), method: :patch, class: 'btn btn-dark btn-sm'
  end

  def task_move_right(task)
    return unless task.can_move_right?
    link_to icon('fas', 'caret-square-right'), move_right_task_path(task), method: :patch, class: 'btn btn-dark btn-sm'
  end
end
