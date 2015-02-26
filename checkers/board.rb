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
    @grid = initialize_grid
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
    Array.new(size ** 2)
  end

  def symbol(position)
    self[position] ? self[position].symbol : "_"
  end

end
