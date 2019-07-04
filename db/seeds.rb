require 'faker'
4.times.each do |t_board|
  board = Board.new(name: "Quadro #{t_board + 1}")
  board.save
  board.front_image.attach(filename: 'test-image.png', io: File.open(Rails.root.join('test', 'support', 'assets', 'test-image.png')))
  4.times.each do |t_step|
    step = board.steps.build(name: "Etapa #{t_step+1}")
    step.save
    2.times.each do |t_task|
      task = step.tasks.build(name: "Tarefa #{t_task+1}")
      task.board_id = board.id
      task.save!
    end
  end
end
