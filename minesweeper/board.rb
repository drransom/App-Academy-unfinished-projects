class Board
  NEIGHBOR_PERMS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1],
                    [1, 0], [1, 1]]

  attr_reader :tiles, :size

  def initialize(num_bombs, board_size)
    @num_bombs = num_bombs
    @size = board_size
    create_tiles #sets @tiles variable
  end

  def create_tiles
    bomb_tile_numbers = select_bombs
    @tiles = {}
    @size.times do |idx1|
      @size.times do |idx2|
        bomb = bomb_tile_numbers.include?(@size * idx1 + idx2)
        @tiles[[idx1, idx2]] = Tile.new([idx1, idx2], self, bomb)
      end
    end
  end

  def select_bombs
    (0...(@size**2)).to_a.sample(@num_bombs)
  end

  def [](position)
    @tiles[[position[0], position[1]]]
  end

  def create_display
    display_string = ""
    @size.times do |idx1|
      @size.times do |idx2|
        display_string += @tiles[[idx1,idx2]].display + ' '
      end
      display_string += "\n"
    end

    display_string.strip
  end

  def bomb_revealed?
    @tiles.any? { |_key, tile| tile.bomb? && tile.revealed? }
  end

  def won?
    revealed = @tiles.each_value { |tile| tile.revealed? && !tile.bomb? }
    revealed == (@size ** 2) - @num_bombs
  end

  def reveal_board
    @tiles.each_value { |tile| tile.reveal if tile.bomb? }
  end

  def valid_position?(arr)
    arr.all? {|value| value.between?(0, @size-1)}
  end

  def calculate_position(tile, perm)
    [tile.position[0] + perm[0], tile.position[1] + perm[1]]
  end

  def find_neighbors_of_tile(tile)
    neighbors = []
    NEIGHBOR_PERMS.each do |perm|
      possible_position = calculate_position(tile, perm)
      neighbors << @tiles[possible_position] if
                    valid_position?(possible_position)
    end

    neighbors
  end
end
