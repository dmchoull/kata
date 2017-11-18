require_relative 'lib/rover'
require_relative 'lib/command_factory'

puts 'Enter rover\'s initial direction and position:'
direction, x, y = gets.split(',').map(&:strip)

rover = Rover.new(direction.upcase, x.to_i, y.to_i)

puts 'Enter command string:'
commands = gets.chomp

commands.chars.map { |char| CommandFactory.create(char.upcase) }.each do |command|
  rover.execute(command)
end

puts "Rover is now located at (#{rover.x},#{rover.y})"