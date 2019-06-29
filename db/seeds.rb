require 'faker'
12.times.each do
  board = Board.new(name: Faker::Job.key_skill)
  board.save
  board.front_image.attach(filename: 'test-image.png', io: File.open(Rails.root.join('spec', 'support', 'assets', 'test-image.png')))
end
