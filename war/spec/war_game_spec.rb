require 'rspec'
require 'war_game'

describe WarGame do
  let(:player1) { double("player1") }
  let(:player2) { double("player2") }
  let(:game) { WarGame.new(player1, player2) }

  describe '#initialize' do

    it 'has two players' do
      expect(game.player1).to be_truthy
      expect(game.player2).to be_truthy
    end

    it 'requires two players' do
      expect { WarGame.new }.to raise_error(ArgumentError)
      expect { WarGame.new(1) }.to raise_error(ArgumentError)
    end
  end

  describe '#play_game' do
    it '#evaluates the game correctly' do
      allow(player1).to receive(:receive_cards)
      allow(player2).to receive(:receive_cards)
      allow(player1).to receive(:lost?).and_return(false)
      allow(player2).to receive(:lost?).and_return(true)

      expect(player1).to receive(:play_cards).with(1).and_return([5])
      expect(player2).to receive(:play_cards).with(1).and_return([5])
      expect(player1).to receive(:play_cards).with(3).and_return([3, 2, 1])
      expect(player2).to receive(:play_cards).with(3).and_return([1, 1, 0])
      expect(player1).to receive(:deck_size).and_return(5)
      expect(player2).to receive(:deck_size).and_return(5)
      expect(player1).to receive(:receive_cards)
      expect(player2).to_not receive(:receive_cards)
      expect(player1).to receive(:celebrate!)

      game.play_game
    end
  end
end
