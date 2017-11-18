require_relative 'lib/rover'
require_relative 'lib/rover_commands'

RoverCommands.define do
  command 'M', ->(rover) { rover.move_forward }
  command 'L', ->(rover) { rover.turn_left }
  command 'R', ->(rover) { rover.turn_right }
end

puts 'Enter rover\'s initial direction and position:'
direction, x, y = gets.split(',').map(&:strip)

rover = Rover.new(direction.upcase, x.to_i, y.to_i)

puts 'Enter command string:'
commands = gets.chomp

commands.chars.map { |command_char| RoverCommands[command_char.upcase] }.each do |command|
  rover.execute(command)
end

puts "Rover is now located at (#{rover.x},#{rover.y})"