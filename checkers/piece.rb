require_relative 'board'

class CheckersPawn
  def initialize(position, color)
    @position = position
    @color = color
    @monarch = false #gender-neutral SJW
  end

  def crown
    @monarch = true
  end

  def monarch?
    @monarch
  end
end
