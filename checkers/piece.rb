require_relative 'board'

class CheckersPawn
  def initialize(position, color)
    @position = position
    @color = color #light or dark
    @monarch = false #gender-neutral SJW
    initialize_moves
  end

  def crown
    @monarch = true
  end

  def monarch?
    @monarch
  end

  private
  FORWARD_STEPS = [[1, 1], [1, -1]]
  FORWARD_JUMPS = [[2, 2], [2, -2]]
  BACKWARD_STEPS = FORWARD_STEPS.reverse_first_element
  BACKWARD_JUMPS = FORWARD_JUMPS.reverse_first_element

  def initialize_moves
    if @color == :light
      @steps = FORWARD_STEPS
      @jumps = FORWARD_JUMPS
    else :dark
      @steps = BACKWARD_STEPS
      @jumps = BACKWARD_JUMPS
    end
  end
end
