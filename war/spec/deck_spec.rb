require 'deck'
require 'rspec'
require 'byebug'

describe Deck do

  describe '#initialize' do
    let(:some_cards) { Array.new(10) { |i| double("card#{i}") } }
    subject(:deck) { Deck.new(some_cards) }

    it 'creates a deck with cards' do
      expect(deck.cards).to eq(some_cards)
    end
  end

  describe 'uses Enumerable' do
    let(:some_cards) { Array.new(10) { |i| double("card#{i}") } }
    subject(:deck) { Deck.new(some_cards) }

    it 'counts cards' do
      expect(deck.count).to eq(some_cards.count)
    end

    it 'enumerates over cards' do
      enum_cards = []
      deck.each do |card|
        enum_cards << card
      end
      expect(deck.count).to eq(enum_cards.count)
      expect(deck.cards).to eq(enum_cards)
    end
  end

  describe '::fresh_deck' do
    let(:deck) { Deck.fresh_deck }

    it 'creates a deck of 52 cards' do
      expect(deck.count).to be 52
    end

    it 'cards are all unique' do
      expect(deck.cards.uniq.count).to be 52
    end
  end

  describe '::two_decks' do
    let(:decks) { Deck.two_decks }
    let(:deck1) { decks[0] }
    let(:deck2) { decks[1] }
    it 'creates two decks' do
      expect(decks.length).to be 2
    end

    it 'splits the deck evenly' do
      expect(deck1.count).to be 26
      expect(deck2.count).to be 26
    end

    it 'the split decks have no repeated cards' do
      expect(decks.any? { |card| deck2.include?(card) }).to be false
    end

    it 'the split decks are deck objects' do
      expect(deck1.is_a?(Deck)).to be true
      expect(deck2.is_a?(Deck)).to be true
    end
  end

  describe '#play_cards' do
    let(:deck) { Deck.fresh_deck }

    it 'plays one card' do
      deck.play_cards(1)
      expect(deck.count).to be 51
    end

    it 'plays multiple cards' do
      deck.play_cards(3)
      expect(deck.count).to be 49
    end
  end

  describe '#receives_cards' do
    let(:decks) { Deck.two_decks }
    let(:deck) { decks[0] }
    let(:deck2) { decks[1] }
    let(:one_card) { [deck2[0]] }
    let(:three_cards) { deck2[0..2] }

    it 'receives one card' do
      deck.receive_cards(one_card)
      expect(deck.count).to be 27
    end

    it 'receives multiple cards' do
      deck.receive_cards(three_cards)
      expect(deck.count).to be 29
    end
  end
end
