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
    until game_over?
      begin
        move = obtain_input_from_current_player
        raise 'invalid input' unless input_valid(move)
        jump = @board.process_move(convert_notation(move))
      rescue
        retry
      end
    end
  end

  def convert_notation(move)
    move.split(/[ ,]+/).map(&:downcase).map { |str| human_to_computer(str) }
  end

  def human_to_computer(str)
    [('a'..'z').to_a.find_index(str[0]), str[1].to_i]
  end

  def input_valid?(move)
    true
  end

  def obtain_input_from_current_player
    begin
      move = request_input_from_player
    rescue
      retry
    end
  end

  def game_over? #TODO
    false
  end

  def display_result
  end

end
