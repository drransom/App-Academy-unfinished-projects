require_relative 'checkers_files'

class CheckersGame
  def initialize(options = {})
    default = { player1: HumanPlayer.new(:light), player2: HumanPlayer.new(:dark),
               must_capture: true, size: 8 }
    options = default.merge(options)
    @must_capture = options[:must_capture]
    @size = options[:size]
    @player1 = options[:player1]
    @player2 = options[:player2]
    @board = CheckersBoard.new(options)
    @current_player = @player1
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
    jump_again = nil
    until board.game_over?(@current_player.color)
      begin
        display_board
        move = @current_player.obtain_input(convert_c_to_h(jump_again))
        raise 'invalid input' unless input_valid?(move)
        move = convert_h_to_c(move)
        if move.length > 2
          board.multi_jump_chain(moves)
        else
          jump_again = board.process_move(move, @current_player.color, jump_again)
          flip_current_player if jump_again
        end
      rescue => e
        puts e.message
        puts e.backtrace
        retry
      end
      flip_current_player
    end
  end

  def flip_current_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def convert_h_to_c(move)
    move.split(/[ ,]+/).map(&:downcase).map { |str| human_to_computer(str) }
  end

  def human_to_computer(str)
    [@size - str[1].to_i, ('a'..'z').to_a.find_index(str[0])]
  end

  def convert_c_to_h(position)
    position ? [@size - position[0], ('a'..'z').to_a[position[0] + 1]].join : nil
  end

  def input_valid?(move)
    true
  end

  def game_over? #TODO
    false
  end

  def display_result
    flip_current_player
    puts "#{@current_player.color} wins!"
  end

  def board
    @board
  end

  def display_board
    puts board.create_display
  end

end

if __FILE__ == $0
  CheckersGame.new().play_game
end
