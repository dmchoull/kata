module RoverCommands
  def self.define(&block)
    rover_commands = CommandDefinitions.new
    rover_commands.instance_eval &block
    @commands = rover_commands.commands
  end

  def self.[](name)
    @commands[name]
  end
end

class CommandDefinitions
  attr_reader :commands

  def initialize
    @commands = {}
  end

  def command(name, body)
    command = Object.new
    command.define_singleton_method(:execute) { |*args| body.call(*args) }
    command.define_singleton_method(:inspect) { name }

    @commands[name] = command
  end
end