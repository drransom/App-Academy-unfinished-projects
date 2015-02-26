require_relative 'board'
require_relative 'checkers_helper'

class CheckersPiece

  FORWARD_STEPS = [[1, 1], [1, -1]]
  FORWARD_JUMPS = [[2, 2], [2, -2]]
  BACKWARD_STEPS = FORWARD_STEPS.reverse_first_element
  BACKWARD_JUMPS = FORWARD_JUMPS.reverse_first_element

  attr_reader :position, :color

  def initialize(position, color, board)
    @position = position
    @color = color #light or dark
    @board = board
    @monarch = false #gender-neutral SJW
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

  def valid_steps
    @steps.each_with_object([]) do |step, object|
      new_position = step.add_array(position)
      object << new_position if empty_and_valid?(new_position)
    end
    object
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

end
