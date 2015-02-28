require 'card'
require 'rspec'

describe Card do
  it 'should initialize with a rank and suit' do
    let(:test_card) { Card.new(:five, :spades) }
    expect(test_card.rank).to be 5
    expect(test_card.suit).to be :spades
  end

  it 'should return an error for an invalid rank and suit' do
    expect(Card.new(:fifteen, :spades)).to raise_error('invalid rank')
    expect(Card.new(:jack, :rubies)).to raise_error('invalid suit')
  end

  it 'should correctly evaluate numbered cards' do
    lets_cards
  end
end
