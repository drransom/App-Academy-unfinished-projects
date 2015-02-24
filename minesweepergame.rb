require 'byebug'
require 'yaml'
require_relative './board'
require_relative './tile'

BOARD_SIZE = 9

class MinesweeperGame
  def self.load_game(filename)
    YAML::load(File.read(filename)).run_game
  end

  attr_reader :board

  def initialize(num_bombs = 9)
    @board = Board.new(num_bombs)
  end

  def run_game
    initialize_game
    until game_over?
      display_board
      move, flag = get_move_from_player
      return if move.nil? #user has chosen to save and quit
      process_move(move, flag)
    end
    reveal_board
    display_board
    game_won? ? win_message : lose_message
  end

  def get_move_from_player
    puts "press f if you would like to flag/unflag a tile, s to save and " +
         "quit, or any key to continue."
    user_input = gets.chomp.downcase
    if user_input[0] == 's'
      request_filename_and_save
      return [nil, nil]
    end
    flag = (user_input[0] == 'f')

    while true
      puts "choose a tile: "
      input = gets.chomp
      move = input.split(/[, ]+/) #TODO fancy split
      break if tile_exist?(move) && tile_valid?(move.map(&:to_i), flag)
    end
    [move.map(&:to_i), flag]
  end

  def tile_exist?(move) #TODO fancy regex
    unless move.length == 2
      puts "Unable to parse input, try again (format: row col)."
      return false
    end
    result = move.all? do |string|
      string.to_i.to_s == string && string.to_i.between?(0, BOARD_SIZE - 1)
    end
    puts "That is not a valid tile" unless result
    result
  end

  def tile_valid?(move, flag)
    tile = @board[move]
    if tile.revealed?
      puts "that tile has already been revealed."
      false
    elsif !flag && tile.flagged?
      puts "that tile has been flagged and must be unflagged to reveal."
      false
    else
      true
    end
  end

  def process_move(move, flag)
    current_tile = @board[move]
    if flag
      current_tile.toggle_flag
    else
      current_tile.reveal
      if current_tile.display == "_"
        current_tile.neighbors.each do |neighbor|
          process_move(neighbor.position, false) unless neighbor.revealed?
        end
      end
    end
  end

  def game_over?
    game_won? || game_lost?
  end

  def game_lost?
    @board.bomb_revealed?
  end

  def game_won?
    @board.won?
  end

  def win_message
    puts "Congratulations, you win!"
  end

  def lose_message
    puts "You got blown up!"
  end

  def display_board
    puts @board.create_display
  end

  def initialize_game
    puts "Welcome to Minesweeper"
  end

  def reveal_board
    @board.reveal_board
  end

  def request_filename_and_save
    puts "please name the file where you would like to save, or enter " +
         "for default."
    user_filename = gets.chomp
    filename = user_filename == "" ? "minesweeper.yml" : user_filename
    save_game(filename)
  end

  def save_game(filename)
    File.open(filename, 'w') do |f|
      f.puts self.to_yaml
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Would you like to load a previous game? (y/n)"
  if gets.chomp[0].downcase == 'y'
    puts "what is the filename?"
    MinesweeperGame.load_game(gets.strip)
  else
    MinesweeperGame.new(9).run_game
  end
end
