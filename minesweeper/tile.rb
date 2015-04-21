class Tile
  attr_reader :display, :position, :neighbors

  def initialize(position, board, bomb = false)
    @bomb = bomb
    @display = '*'
    @board = board
    @position = position
    @neighbors = []
    @revealed = false
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
    @neighbors = @board.find_neighbors_of_tile(self)
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
