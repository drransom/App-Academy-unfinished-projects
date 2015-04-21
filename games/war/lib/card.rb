class Card
  attr_reader :rank, :suit, :symbol
  include Comparable

  SUITS = [:clubs, :diamonds, :spades, :hearts]
  RANKS = [:ace, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten,
           :jack, :queen, :king]
  RANK_SYMBOLS = {ace: "A", two: "2", three: "3", four: "4", five: "5",
                    six: "6", seven: "7", eight: "8", nine: "9", ten: "10",
                    jack: "J", queen: "Q", king: "K"}
  SUIT_SYMBOLS = {clubs: "♠", hearts: "♥", diamonds: "♦", spades: "♠"}

  def initialize(rank, suit)
    raise 'invalid rank' unless RANKS.include? rank
    raise 'invalid suit' unless SUITS.include? suit
    @rank = rank
    @suit = suit
    @symbol = RANK_SYMBOLS[rank] + SUIT_SYMBOLS[suit]
  end

  def <=>(other)
    RANKS.find_index(rank) <=> RANKS.find_index(other.rank)
  end

end
