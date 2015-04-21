require 'player'

describe Player do

  let(:deck) { double("deck") }
  let(:game) { double("game") }
  subject(:player) { Player.new }
  let(:cards) { double("cards") }

  describe '#deck' do
    it 'gives a deck to a player' do
      player.add_deck(deck)
      expect(player.deck).to eq(deck)
    end
  end

  describe '#game' do
    it 'assigns a player to a game' do
      player.add_game(game)
      expect(player.game).to eq(game)
    end
  end

  describe '#play_cards' do
    it 'calls the deck object and returns the cards played' do
      player.add_deck(deck)
      expect(deck).to receive(:play_cards).with(3).and_return(cards)
      expect(player.play_cards(3)).to eq(cards)
    end
      end

  describe '#receive_cards' do
    it 'calls the deck object' do
      player.add_deck(deck)
      expect(deck).to receive(:receive_cards).with(3)
      player.receive_cards(3)
    end
  end

  describe '#celebrate!' do
    it 'celebrates' do
      expect(player.celebrate!).to be_truthy
    end
  end

  describe '#lost?' do
    it 'loses when deck is empty' do
      player.add_deck(deck)
      expect(deck).to receive(:empty?).and_return(true)
      expect(player.lost?).to be true
    end

    it "doesn't lose when deck isn't empty" do
      player.add_deck(deck)
      expect(deck).to receive(:empty?).and_return(false)
      expect(player.lost?).to be false
    end
  end
end
