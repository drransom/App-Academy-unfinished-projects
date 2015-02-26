require_relative 'game'
require_relative 'checkers_helper'
require_relative 'players.rb'
require 'byebug'

class CheckersBoard

  def initialize(options = {})
    defaults = {player1: HumanPlayer.new(:light), player2: HumanPlayer.new(:dark),
                size: 8}
    values = defaults.merge(options)
    @player1 = values[:player1]
    @player2 = values[:player2]
    @size = values[:size]
    initialize_grid
  end

  def[](position)
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

  private

  def[]=(position, new_value)
    @grid[convert_dimensions(position)] = new_value
  end

  def size
    @size
  end

  def convert_dimensions(position)
    position[0]*size + position[1]
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

  def dark_square?(position)
    row, col = position
    row.even? ? col.odd? : col.even?
  end

end
