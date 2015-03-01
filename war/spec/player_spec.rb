require 'player'

describe Player do

  let(:deck) { double("deck") }
  let(:game) { double("game") }
  subject(:player) { Player.new(deck, game) }
  let(:cards) { double("cards") }

  describe '#initialize' do
    it 'has a deck and a game' do
      expect(player.deck).to eq(deck)
      expect(player.game).to eq(game)
    end
  end

  describe '#play_cards' do
    it 'calls the deck object and returns the cards played' do
      expect(deck).to receive(:play_cards).with(3).and_return(cards)
      expect(player.play_cards(3)).to eq(cards)
    end
      end

  describe '#receive_cards' do
    it 'calls the deck object' do
      expect(deck).to receive(:receive_cards).with(3)
      player.receive_cards(3)
    end
  end

  describe '#celebrate!' do
    it 'celebrates' do
      expect(player.celebrate!).to be_truthy
    end
  end
end
