require_relative 'checkers_files'
require 'byebug'

class CheckersBoard

  def initialize(options = {})
    defaults = {player1: HumanPlayer.new(:light), player2: HumanPlayer.new(:dark),
                size: 8, must_capture: true}
    values = defaults.merge(options)
    @player1 = values[:player1]
    @player2 = values[:player2]
    @size = values[:size]
    @must_capture = values[:must_capture]
    initialize_grid
  end

  def [](position)
    @grid[convert_dimensions(position)]
  end

  def create_display
    columns = ('a'..'z').to_a[0...size].join(" ")
    display_string = "  " + columns + "\n"
    size.times do |row|
      row_symbol = size - row
      display_string += "#{row_symbol} "
      size.times do |col|
        display_string += "#{symbol([row, col])} "
      end
      display_string += "#{row_symbol}\n"
    end
    display_string + "  #{columns}"
  end

  def process_move(move, color, jump_again)
    from, to = move
    from_square = self[from]
    raise 'No piece there.' unless occupied?(from)
    raise 'Not your piece.' unless color == from_square.color
    raise 'You must move the same piece again.' if jump_again && jump_again != from
    jump = from_square.valid_jumps.include?(to)
    step = from_square.valid_steps.include?(to)
    raise 'Not a valid move.' unless jump || step

    jump_again_flag = jump ? from_square.jump!(to) : false
    if step
      raise 'You must capture if possible.' if @must_capture & can_jump?(color)
      from_square.step!(to)
    end
    jump_again_flag
  end

  def game_over?(color)
    pieces(color).nil? || no_valid_moves?(color)
  end

  def move_piece(old_pos, new_pos)
    self[new_pos] = self[old_pos]
    self[old_pos] = nil
  end

  def valid_position?(position)
    row, col = position
    (0...size).include?(row) && (0...size).include?(col)
  end

  def empty_position?(position)
    self[position].nil?
  end

  def occupied?(position)
    !empty_position?(position)
  end

  def remove_piece(position)
    self[position] = nil
  end

  def can_jump?(color)
    pieces(color).any? { |piece| !piece.valid_jumps.empty? }
  end

  def can_step?(color)
    pieces(color).any? { |piece| !piece.valid_steps.empty? }
  end

  def last_row?(piece)
    last_row = (piece.color == :dark) ? 0 : size-1
    piece.position[0] == last_row
  end

  private

  def []=(position, new_value)
    @grid[convert_dimensions(position)] = new_value
  end

  def size
    @size
  end

  def convert_dimensions(position)
    position[0] * size + position[1]
  end

  def initialize_grid
    @grid = Array.new(size ** 2)
    create_pieces(:light)
    create_pieces(:dark)
  end

  def symbol(position)
    self[position] ? self[position].symbol : "_"
  end

  def create_pieces(color)
    first_row = (color == :light) ? 0 : size - 3
    (first_row..(first_row + 2)).each do |row|
      size.times do |col|
        pos = [row, col]
        self[pos] = CheckersPiece.new(pos, color, self) if dark_square?(pos)
      end
    end
  end

  def pieces(color)
    @grid.compact.select { |piece| piece.color == color }
  end

  def dark_square?(position)
    row, col = position
    row.even? ? col.odd? : col.even?
  end

  def no_valid_moves?(color)
    !can_jump?(color) && !can_step?(color)
  end

end
