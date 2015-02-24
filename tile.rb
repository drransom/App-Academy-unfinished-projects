class Tile
  # TA: tiles hash stored in the board?
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
