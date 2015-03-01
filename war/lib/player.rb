require 'deck'

class Player
  attr_reader :deck, :game

  def initialize(deck, game)
    @deck, @game = deck, game
  end

  def play_cards(num)
    deck.play_cards(num)
  end

  def receive_cards(cards)
    deck.receive_cards(cards)
  end

  def celebrate!
    puts "Let's all celebrate and have a good time!"
    true
  end
end
