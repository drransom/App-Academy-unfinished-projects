require_relative 'card'

class Deck
  include Enumerable
  attr_reader :cards

  def self.fresh_deck
    cards = []
    Card::RANKS.each do |rank|
      Card::SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end
    Deck.new(cards)
  end

  def self.two_decks
    complete_deck = Deck.fresh_deck
    complete_deck.shuffle!
    mid = complete_deck.length / 2
    [Deck.new(complete_deck[0...mid]), Deck.new(complete_deck[mid..-1])]
  end

  def initialize(cards)
    @cards = cards
  end

  def each &prc
    @cards.each { |i| prc.call(i) }
  end

  def shuffle!
    @cards.shuffle!
  end

  def [](num)
    @cards[num]
  end

  def length
    @cards.length
  end

  def play_cards(n)
    @cards.shift(n)
  end

  def receive_cards(new_cards)
    @cards.concat(new_cards)
  end

  private
end
