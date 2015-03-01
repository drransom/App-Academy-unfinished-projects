require 'card'
require 'rspec'

describe Card do
  lets_cards
  let(:test_card) { Card.new(:five, :spades) }

  it 'should initialize with a rank and suit' do
    expect(test_card.rank).to be(:five)
    expect(test_card.suit).to be :spades
  end

  it 'should return an error for an invalid rank and suit' do
    expect { Card.new(:fifteen, :spades) }.to raise_error('invalid rank')
    expect { Card.new(:jack, :rubies) }.to raise_error('invalid suit')
  end

  it 'should correctly evaluate numbered cards' do
    expect(s9).to be > h3
    expect(h3).to be < s9
    expect(h10 <=> s10).to eq(0)
    expect(h8).to be > c6
    expect(s6).to be < h8
  end

  it 'should correctly evaluate aces relative to numbers' do
    expect(sa <=> ha).to be 0
    expect(ca).to be < s3
    expect(h10).to be > (ca)
  end

  it 'should correctly evaluate face cards' do
    expect(sk).to be > sq
    expect(sq).to be > hj
    expect(hj).to be < sq
    expect(c10).to be < ck
  end
end
