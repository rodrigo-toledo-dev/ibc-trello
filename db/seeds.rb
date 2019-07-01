require 'faker'
4.times.each do
  board = Board.new(name: Faker::Job.key_skill)
  board.save
  board.front_image.attach(filename: 'test-image.png', io: File.open(Rails.root.join('spec', 'support', 'assets', 'test-image.png')))
  4.times.each do |t|
    step = board.steps.build(name: "Passo #{t+1}")
    step.save
  end
end
