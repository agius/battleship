require 'spec_helper'

describe Battleship do

  let(:battleship){ Battleship.new }
  let(:ship){ Ship.new(1,1,:horizontal,4) }

  before { battleship.add_ship(ship) }

  it "initializes without errors" do
    expect { Battleship.new }.to_not raise_error
  end

  it "fires on ships" do
    expect(battleship.fire(1,1)).to eq(:hit)
    expect(battleship.fire(2,3)).to eq(:miss)
  end

  it "wins when last hit is fired" do
    ship.squares[0..-2].each do |coords|
      expect(battleship.fire(*coords)).to eq(:hit)
      expect(battleship.hits).to include(coords)
      expect(battleship.win?).to_not be true
    end
    expect(battleship.fire(*ship.squares.last)).to eq(:win)
    expect(battleship.win?).to be true
  end

end