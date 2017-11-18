require_relative 'move_forward_command'
require_relative 'turn_left_command'
require_relative 'turn_right_command'

class CommandFactory
  def self.create(command_string)
    case command_string
      when 'M'
        MoveForwardCommand.new
      when 'R'
        TurnRightCommand.new
      when 'L'
        TurnLeftCommand.new
      else
        raise "Unknown command \"#{command_string}\""
    end
  end
end