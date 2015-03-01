require 'deck'

class Player
  attr_reader :deck, :game

  def initialize
  end

  def add_deck(deck)
    @deck = deck
  end

  def add_game(game)
    @game = game
  end

  def play_cards(num)
    deck.play_cards(num)
  end

  def receive_cards(cards)
    deck.receive_cards(cards)
  end

  def lost?
    deck.empty?
  end

  def celebrate!
    puts "Let's all celebrate and have a good time!"
    true
  end

end
