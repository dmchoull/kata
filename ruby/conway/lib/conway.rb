Dir[File.expand_path('../../lib/*.rb', __FILE__)].each { |f| require f }

module Conway
  def self.run(width, height, initial_cells)
    init(width, height, initial_cells)

    while true
      @life.next_generation
      @generation += 1
      display(width)
    end
  end

  private

  def self.init(width, height, initial_cells)
    @life = Life.new(width, height)
    @generation = 1
    initial_cells.times { @life.add_cell(rand(width) + 1, rand(height) + 1) }
    display(width)
  end

  def self.display(width)
    system('clear')

    indent = ' ' * (width - (@generation.to_s.length + 1))

    puts "#{indent}#{@generation}"
    puts '_' * (width * 2 - 1)
    puts @life.display
    puts "\n"

    sleep 1
  end
end

if ARGV.length == 3
  Conway.run(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i)
end