require_relative 'player'
require_relative 'deck'
require 'byebug'

class WarGame
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def play_game
    p1deck, p2deck = Deck.two_decks
    player1.add_game(self)
    player2.add_game(self)
    player1.add_deck(p1deck)
    player2.add_deck(p2deck)
    rounds_played = 0
    until rounds_played >= 1 && game_over?
      rounds_played +=1
      play_round
    end
    celebrate!
  end

  def play_round
    p1_cards = player1.play_cards(1)
    p2_cards = player2.play_cards(1)
    compare_cards(p1_cards, p2_cards)
  end

  def compare_cards(p1_cards, p2_cards)
    case p1_cards[-1] <=> p2_cards[-1]
    when 1 #p1 wins
      player1.receive_cards(p1_cards + p2_cards)
    when -1 #p2 wins
      player2.receive_cards(p2_cards + p1_cards)
    else
      war!(p1_cards, p2_cards)
    end
  end

  def war!(p1_cards, p2_cards)
    if player1.deck_size < 3 || player2.deck_size < 3
      @winner = p2_cards.length < 3 ? player1 : player2
      return
    end
    p1_cards += player1.play_cards(3)
    p2_cards += player2.play_cards(3)
    compare_cards(p1_cards, p2_cards)
  end

  def game_over?
    return false unless player1.lost? || player2.lost?
    @winner = player1.lost? ? player2 : player1
  end

  def celebrate!
    @winner.celebrate!
  end
end


if __FILE__ == $0
  WarGame.new(Player.new("Sarah"), Player.new("Angelina")).play_game
end
