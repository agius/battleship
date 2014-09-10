require 'grid'
require 'ship'

class Battleship

  def initialize
    @grid = Grid.new
  end

  def fire(x, y)
    _live_ships = live_ships
    is_hit = @grid.fire(x,y)
    return :win if win?
    is_sunk = (live_ships - _live_ships).any?
    return :sunk if is_sunk
    return :hit if is_hit
    :miss
  end

  def method_missing(*args)
    @grid.send(*args)
  end

end