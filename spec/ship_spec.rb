require 'spec_helper'

describe Ship do

  let(:ship){ Ship.new(1, 5, :horizontal, 3) }
  let(:hit_loc){ [1,5] }
  let(:miss_loc){ [6,7] }

  it "initializes ship with no errors" do
    expect(ship.x).to eq(1)
    expect(ship.y).to eq(5)
    expect(ship.orientation).to eq(:horizontal)
    expect(ship.length).to eq(3)
  end

  it "correctly records all squares" do
    expect(ship.squares).to eq([[1,5],[2,5],[3,5]])
  end

  it "should be hit when in range" do
    expect(ship.is_hit?(*hit_loc)).to be true
    expect(ship.is_hit?(*miss_loc)).to_not be true
  end

  it "should record hits" do
    expect(ship.fire(*hit_loc)).to be true
    expect(ship.hits).to include(hit_loc)
    expect(ship.fire(*miss_loc)).to be false
    expect(ship.hits).to_not include(miss_loc)
  end

  it "should be dead when all sqaures hit" do
    ship.hits = ship.squares
    expect(ship.dead?).to be true
    ship.hits = []
    expect(ship.dead?).to_not be true
  end

end