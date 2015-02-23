BOARD_SIZE = 9
class MinesweeperGame
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



  def [](xcord, ycord)
    @tiles.select do |tile|
      tile.position == [xcord, ycord]
    end[0]
  end



end

class Tile
  @@tiles = {}
  def self.tiles
    @@tiles
  end
  attr_reader :bomb, :display, :position
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

  def flag
    @display = "F"
  end

  def flagged?
    @display == "F"
  end

  def revealed?
    @revealed
  end

  def count_bombs
    @neighbors.inject(0) { |memo, neighbor| neighbor.bomb ? memo + 1 : memo }
  end
end
