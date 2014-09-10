require 'spec_helper'

describe Grid do

  let(:grid){ Grid.new }
  let(:ship){ Ship.new(1, 1, :horizontal, 5) }
  let(:conflict_ship){ Ship.new(1,1, :vertical, 3) }
  let(:noconflict_ship){ Ship.new(1, 2, :horizontal, 4) }

  it "should initialize without errors" do
    expect(grid).to be_a(Grid)
  end

  context 'with one ship' do

    before { grid.add_ship(ship) }

    it "should add a ship" do
      expect(grid.ships).to include(ship)
    end

    it "should raise error on conflict" do
      expect{grid.add_ship(conflict_ship)}.to raise_error
      expect{grid.add_ship(noconflict_ship)}.to_not raise_error
    end

    it "should hit first ship on grid" do
      expect(grid.fire(1,1)).to be true
      expect(ship.hits).to include([1,1])
      expect(grid.fire(6,7)).to be false
      expect(ship.hits).to_not include([6,7])
    end

    it "should report a win when all ships destroyed" do
      expect(grid.win?).to_not be true
      grid.fire(6,7)
      expect(grid.win?).to_not be true

      grid.fire(1,1)
      expect(grid.win?).to_not be true

      ship.squares.each{|x,y| grid.fire(x,y) }
      expect(grid.win?).to be true
    end

    it "should collect squares from all ships" do
      grid.add_ship(noconflict_ship)
      grid.add_ship(Ship.new(1, 3, :horizontal, 4))
      grid.add_ship(Ship.new(1, 4, :horizontal, 2))

      expect(grid.squares).to include([1,1], [1,2], [3,3], [3,3])
    end

    it "should report all hits" do
      expect(grid.fire(1,1)).to be true
      expect(grid.fire(2,1)).to be true
      expect(grid.hits).to include([1,1], [2,1])
    end
  end

end