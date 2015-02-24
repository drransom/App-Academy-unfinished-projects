require 'byebug'
BOARD_SIZE = 9
class MinesweeperGame
  attr_reader :board
  def initialize(num_bombs = 9)
    @board = Board.new(num_bombs)
  end

  def run_game
    initialize_game
    until game_over?
      display_board
      move, flag = get_move_from_player
      process_move(move, flag)
    end
    reveal_board
    display_board
    game_won? ? win_message : lose_message
  end

  def get_move_from_player
    puts "press f if you would like to flag/unflag a tile, or any key to continue."
    flag = (gets.chomp.downcase[0] == 'f')
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
end

class Board
  attr_reader :tiles
  def initialize(num_bombs = 9)
    @num_bombs = num_bombs
    create_tiles #sets @tiles variable
  end

  def create_tiles
    bomb_tile_numbers = select_bombs
    @tiles = []
    BOARD_SIZE.times do |idx1|
      BOARD_SIZE.times do |idx2|
        bomb = bomb_tile_numbers.include?(BOARD_SIZE*idx1 + idx2)
        @tiles << Tile.new([idx1, idx2], bomb)
      end
    end
  end

  def select_bombs
    (0...(BOARD_SIZE**2)).to_a.sample(@num_bombs)
  end

  def [](position)
    @tiles.select do |tile|
      tile.position == [position[0], position[1]]
    end[0]
  end

  def create_display
    display_string = ""
    BOARD_SIZE.times do |idx1|
      BOARD_SIZE.times do |idx2|
        display_string += self[[idx1,idx2]].display + ' '
      end
      display_string += "\n"
    end
    display_string.strip
  end

  def bomb_revealed?
    @tiles.any? { |tile| tile.bomb? && tile.revealed? }
  end

  def won?
    revealed = @tiles.count { |tile| tile.revealed? && !tile.bomb? }
    revealed == (BOARD_SIZE ** 2) - @num_bombs
  end

  def reveal_board
    @tiles.each { |tile| tile.reveal if tile.bomb? }
  end
end

class Tile
  @@tiles = {}
  def self.tiles
    @@tiles
  end
  attr_reader :display, :position, :neighbors
  NEIGHBOR_PERMS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1],
                    [1, 0], [1, 1]]

  def initialize(position, bomb = false)
    @explored = false
    @bomb = bomb
    @display = '*'
    @position = position
    @neighbors = []
    @revealed = false
    @@tiles[@position] = self
  end

  def reveal
    @revealed = true
    if @bomb
      @display = "X"
    else
      find_neighbors if @neighbors.empty?
      n_bombs = count_bombs
      @display = n_bombs > 0 ? n_bombs.to_s : "_"
    end
  end

  def find_neighbors
    NEIGHBOR_PERMS.each do |perm|
      possible_position = calculate_position(perm)
      @neighbors << @@tiles[possible_position] if
                    valid_position?(possible_position)
    end
  end

  def valid_position?(arr)
    arr.all? {|value| value.between?(0, BOARD_SIZE-1)}
  end

  def calculate_position(perm)
    [@position[0] + perm[0], @position[1] + perm[1]]
  end

  def toggle_flag
    @display = (@display == "F") ? "*" : "F"
  end

  def flagged?
    @display == "F"
  end

  def revealed?
    @revealed
  end

  def bomb?
    @bomb
  end

  def count_bombs
    @neighbors.inject(0) { |memo, neighbor| neighbor.bomb? ? memo + 1 : memo }
  end
end

if __FILE__ == $PROGRAM_NAME
  MinesweeperGame.new(9).run_game
end
