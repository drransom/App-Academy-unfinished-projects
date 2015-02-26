require_relative 'board'
require_relative 'checkers_helper'
require 'byebug'

class CheckersPiece

  FORWARD_STEPS = [[1, 1], [1, -1]]
  FORWARD_JUMPS = [[2, 2], [2, -2]]
  BACKWARD_STEPS = FORWARD_STEPS.reverse_first_element
  BACKWARD_JUMPS = FORWARD_JUMPS.reverse_first_element

  attr_reader :color, :symbol, :board
  attr_accessor :position

  def initialize(position, color, board)
    @position = position
    @color = color #light or dark
    @board = board
    @monarch = false #gender-neutral SJW
    @symbol = (color == :dark) ? '*' : '@'
    initialize_moves
  end

  def crown!
    return false if monarch?
    @monarch = true
    steps = (FORWARD_STEPS + BACKWARD_STEPS)
    jumps = (FORWARD_JUMPS + BACKWARD_JUMPS)
  end

  def monarch?
    @monarch
  end

  def step(new_position)
    raise 'not a valid step' unless valid_steps.include?(new_position)
    update_position(new_position)
  end

  def valid_steps
    steps.each_with_object([]) do |step, valid_steps|
      new_position = step.add_array(position)
      valid_steps << new_position if empty_and_valid?(new_position)
    end
  end

  def jump(new_position)
    raise 'not a valid jump' unless valid_jumps.include?(new_position)
    old_position = position
    update_position(new_position)
    board.remove_piece(old_position.average(position))
  end

  def valid_jumps
    jumps.each_with_object([]) do |jump, valid_jumps|
      new_position = jump.add_array(position)
      next unless empty_and_valid?(new_position)
      mid_position = new_position.average(position)
      valid_jumps << new_position if occupied_by_opponent?(mid_position)
    end
  end

  private

  def initialize_moves
    if color == :light
      @steps = FORWARD_STEPS
      @jumps = FORWARD_JUMPS
    else
      @steps = BACKWARD_STEPS
      @jumps = BACKWARD_JUMPS
    end
  end

  def board
    @board
  end

  def steps
    @steps
  end

  def steps=(new_steps)
    @steps = new_steps
  end

  def jumps
    @jumps
  end

  def jumps=(new_jumps)
    @jumps = new_jumps
  end

  def empty_and_valid?(position)
    valid_position?(position) && empty?(position)
  end

  def valid_position?(position)
    board.valid_position?(position)
  end

  def empty?(position)
    board.empty_position?(position)
  end

  def update_position(new_pos)
    old_pos = position
    @position = new_pos
    board.move_piece(old_pos, position)
  end

  def occupied_by_opponent?(position)
    board.occupied?(position) && board[position].color != color
  end

end
