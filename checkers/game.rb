require_relative 'checkers_files'

class CheckersGame
  def initialize(options = {})
    default = {capture_required: true, size: 8}
    options = default.merge(options)
    @capture_required = options[:capture_required]
    @size = options[:size]
    @board = CheckersBoard.new(options)
  end

  def play_game
    initialize_game
    run_game
    display_result
  end

  def initialize_game
    puts "Welcome to checkers, the first nontrivial game " +
         "that was perfectly solved!"
  end

  def run_game
  end

  def display_result
  end

end
