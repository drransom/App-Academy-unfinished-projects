require_relative 'game'
require_relative 'checkers_helper'
require_relative 'players.rb'

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


end
