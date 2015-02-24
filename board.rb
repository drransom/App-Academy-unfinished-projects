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
        bomb = bomb_tile_numbers.include?(BOARD_SIZE * idx1 + idx2)
        @tiles << Tile.new([idx1, idx2], bomb)
      end
    end
  end

  def select_bombs
    (0...(BOARD_SIZE**2)).to_a.sample(@num_bombs)
  end

  def [](position)
    @tiles.find { |tile| tile.position == [position[0], position[1]] }
    # @tiles.select do |tile|
    #   tile.position == [position[0], position[1]]
    # end[0]
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
