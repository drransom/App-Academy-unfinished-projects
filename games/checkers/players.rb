require_relative 'checkers_files'

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def obtain_input(jump_again = false)
    if jump_again
      puts "You must move the piece at #{jump_again}."
      gets.chomp
    else
      puts "It is #{color}'s turn."
      puts "Please select the piece to move from and to."
      gets.chomp
    end
  end
end
